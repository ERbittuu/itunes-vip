//
//  MovieDetailViewController.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit
import AVKit

protocol MusicDetailDisplayLogic: AnyObject, BaseViewDisplayLogic {
    func displayInfo(viewModel: MusicResponseModel)
}

class MusicDetailViewController: BaseViewController {

    var interactor: MusicDetailBusinessLogic?
    var router: (NSObjectProtocol & MusicDetailRoutingLogic & MusicDetailDataPassing)?

    private var deta: MusicResponseModel?

    let titleLabel: UILabel = {
        let label = UILabel.init()
        label.text = Constants.HomeScreen.titleLabel
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = Constants.Styles.primaryColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let artistLabel: UILabel = {
        let label = UILabel.init()
        label.text = Constants.HomeScreen.titleLabel
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = Constants.Styles.secondaryDarkColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let playVideoButton: UIButton = {
        let button = UIButton.init()
        button.setTitle(Constants.MusicDetails.playVideo, for: .init())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(Constants.Styles.primaryColor, for: .init())
        button.addTarget(self, action: #selector(play), for: .touchUpInside)
        return button
    }()

    let imageView: CustomImageView = {
        let imageView = CustomImageView.init()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = Constants.Styles.secondaryColor.cgColor
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()

    let priceLabel: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Constants.Styles.primaryColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDetailInfo()
    }

    private func setupViews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(artistLabel)
        self.view.addSubview(imageView)
        self.view.addSubview(playVideoButton)
        self.view.addSubview(priceLabel)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        artistLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }

        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(artistLabel.snp.bottom).offset(32)
            make.height.width.equalTo(self.view.frame.size.width / 2)
        }

        playVideoButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(imageView.snp.bottom).offset(16)
        }

        priceLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(playVideoButton.snp.bottom).offset(16)
        }
    }

    private func setDetailInfo() {
        interactor?.updateDetail()
    }
    @objc private func play() {
        if let videoURL = deta?.previewUrl {
            let player = AVPlayer(url: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }

}

extension MusicDetailViewController: MusicDetailDisplayLogic {

    func displayInfo(viewModel: MusicResponseModel) {
        deta = viewModel
        titleLabel.text = viewModel.trackName ?? viewModel.collectionName
        artistLabel.text = viewModel.artistName.isEmpty ? nil : "(\(viewModel.artistName))"
        imageView.loadImageUsingUrlString(url: viewModel.artworkUrl100, placeHolderImage: nil)
        if viewModel.previewUrl != nil {
            playVideoButton.isHidden = false
        } else {
            playVideoButton.isHidden = true
        }
        let price = viewModel.collectionPrice == 0.0
        ? Constants.MusicDetails.free
        : "\(viewModel.collectionPrice!) \(viewModel.currency ?? "$")"
        priceLabel.text = "\(Constants.MusicDetails.price): \(price)\n\(viewModel.copyright ?? "")"

        if viewModel.collectionViewUrl != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search,
                                                                target: self, action: #selector(openBrowser))
        }
    }

    @objc private func openBrowser() {
        if let collectionViewUrl = deta?.collectionViewUrl {
            if UIApplication.shared.canOpenURL(collectionViewUrl) {
                UIApplication.shared.open(collectionViewUrl, completionHandler: nil)
            }
        }
    }
}
