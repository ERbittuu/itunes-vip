//
//  SearchResultViewController.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit
import SnapKit
import CollectionKit

protocol SearchResultDisplayLogic: AnyObject, BaseViewDisplayLogic {
    func showResult(items: [[MusicResponseModel]], types: [String])
}

class SearchResultViewController: BaseViewController {
    var interactor: SearchResultBusinessLogic?
    var router: (NSObjectProtocol & SearchResultRoutingLogic & SearchResultDataPassing)?

    var dataSources = [ArrayDataSource<MusicResponseModel>]()
    var sourcesType = [String]()

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        updateUI()
    }

    let segment: UISegmentedControl = {
        let tempSegment = UISegmentedControl(items: [Constants.SearchResult.gridLabel,
                                                     Constants.SearchResult.listLabel])
        let tintColor = Constants.Styles.primaryColor
        let backgroundColor = Constants.Styles.backgroundColor
        let tintColorImage = UIImage(color: tintColor)
        // Must set the background image for normal to something (even clear) else the rest won't work
        tempSegment.setBackgroundImage(UIImage(color: backgroundColor),
                                       for: .normal, barMetrics: .default)
        tempSegment.setBackgroundImage(tintColorImage,
                                       for: .selected,
                                       barMetrics: .default)
        tempSegment.setBackgroundImage(UIImage(color: tintColor.withAlphaComponent(0.2)),
                                       for: .highlighted, barMetrics: .default)
        tempSegment.setBackgroundImage(tintColorImage,
                                       for: [.highlighted, .selected],
                                       barMetrics: .default)
        tempSegment.setTitleTextAttributes([.foregroundColor: tintColor,
                                            .font: UIFont.systemFont(ofSize: 13, weight: .regular)],
                                           for: .normal)
        tempSegment.setTitleTextAttributes([.foregroundColor: backgroundColor,
                                            .font: UIFont.systemFont(ofSize: 13, weight: .regular)],
                                           for: .selected)
        tempSegment.setDividerImage(tintColorImage, forLeftSegmentState: .normal,
                                    rightSegmentState: .normal,
                                    barMetrics: .default)
        tempSegment.layer.borderWidth = 1
        tempSegment.layer.borderColor = tintColor.cgColor
        return tempSegment
    }()
    let columnTypeView = UIView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = Constants.SearchResult.titleLabel
        self.navigationController?.setNavigationBarHidden(false, animated: false)
   }

    // MARK: Views

    private let collectionView = CollectionView()

    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(columnTypeView)
        columnTypeView.addSubview(segment)
    }

    private func setupConstraints() {
        columnTypeView.snp.makeConstraints({
            $0.top.left.right.equalTo(view).inset(8)
            $0.height.equalTo(32)
        })
        collectionView.snp.makeConstraints({
            $0.left.right.equalTo(columnTypeView)
            $0.top.equalTo(columnTypeView.snp.bottom).offset(8)
            $0.bottom.equalTo(view)
        })

        segment.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })

        let segment = segment
        segment.addTarget(self, action: #selector(changeCollectionLayout), for: .valueChanged)

        collectionView.contentInset = UIEdgeInsets.zero
        segment.selectedSegmentIndex = 0
        changeCollectionLayout(segment: segment)
    }

    private func updateUI() {
        interactor?.updateMusic()
    }

    private func listViewSource() -> ClosureViewSource<MusicResponseModel, UIView> {
        return ClosureViewSource(viewUpdater: { (view: UIView, item: MusicResponseModel, _: Int) in
            _ = view.subviews.map({
                $0.removeFromSuperview()
            })

            let imageView = CustomImageView()
            view.addSubview(imageView)
            imageView.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })

            imageView.contentMode = .scaleAspectFill
            imageView.loadImageUsingUrlString(url: item.artworkUrl100,
                                              placeHolderImage: UIImage())
            view.layer.cornerRadius = 8
            view.clipsToBounds = true
        })
    }

    private func gridViewSource() -> ClosureViewSource<MusicResponseModel, UIView> {
        ClosureViewSource(viewUpdater: { (view: UIView, item: MusicResponseModel, _: Int) in
           _ = view.subviews.map({
               $0.removeFromSuperview()
           })
           let imageView = CustomImageView()
           view.addSubview(imageView)
           imageView.snp.makeConstraints({
               $0.leading.equalToSuperview().inset(8)
               $0.top.bottom.equalToSuperview().inset(4)
               $0.width.equalTo(96 - 8)
           })

           let trackName = UILabel()
           trackName.text = item.trackName ?? item.collectionName
           trackName.numberOfLines = 2
           trackName.font = UIFont.boldSystemFont(ofSize: 15)
           trackName.textColor = .white

           let artistName = UILabel()
           artistName.text = item.artistName
           artistName.textColor = .white
           artistName.numberOfLines = 2
           artistName.font = UIFont.systemFont(ofSize: 13)

           let stackView = UIStackView()
           stackView.distribution = .fillEqually
           stackView.alignment = .leading
           stackView.axis = .vertical
           stackView.addArrangedSubview(trackName)
           stackView.addArrangedSubview(artistName)

           view.addSubview(stackView)
           stackView.snp.makeConstraints({
               $0.top.bottom.equalTo(imageView).offset(4)
               $0.leading.equalTo(imageView.snp.trailing).offset(8)
               $0.trailing.equalToSuperview().inset(4)
           })

           imageView.contentMode = .scaleAspectFill
           imageView.loadImageUsingUrlString(url: item.artworkUrl100,
                                             placeHolderImage: UIImage())
           view.layer.cornerRadius = 8
           view.clipsToBounds = true
       })
    }
    @objc func changeCollectionLayout(segment: UISegmentedControl) {
        let rowLayout = segment.selectedSegmentIndex != 1

        let sections: [Provider] = dataSources.map { item in
          return BasicProvider(
            dataSource: item,
            viewSource: ComposedViewSource(viewSourceSelector: { _ in
                if rowLayout {
                    return self.listViewSource()
                } else {
                    return self.gridViewSource()
                }
            }),
            sizeSource: { (_, _, size) -> CGSize in
                return rowLayout
                ? CGSize(width: (size.width / 3) - 8, height: 160)
                : CGSize(width: size.width, height: 96)
            },
            layout: FlowLayout(lineSpacing: 8,
                               interitemSpacing: 8,
                               justifyContent: .start,
                               alignItems: .center),
            animator: WobbleAnimator()) { context in // tap handler
                print(context.data)
                self.router?.routeToDetail(with: context.data)
              }
        }

        let provider = ComposedHeaderProvider(
          headerViewSource: { (view: UILabel, _, index) in
              view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
              view.textColor = .white
              view.textAlignment = .left
              let item = self.sourcesType[index]
              view.text = "  \(item)"
          },
          headerSizeSource: { (_, _, maxSize) -> CGSize in
            return CGSize(width: maxSize.width, height: 32)
          },
          sections: sections
        )

        collectionView.provider = provider
        collectionView.reloadData()
    }

}

// MARK: - Display logic implementation

extension SearchResultViewController: SearchResultDisplayLogic {

    func showResult(items: [[MusicResponseModel]], types: [String]) {
        for item in items {
            dataSources.append(ArrayDataSource<MusicResponseModel>(data: item))
        }
        sourcesType.append(contentsOf: types)
        changeCollectionLayout(segment: segment)
    }
}
