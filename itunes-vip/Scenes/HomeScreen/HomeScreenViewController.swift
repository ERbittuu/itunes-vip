//
//  HomeScreenViewController.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit
import SnapKit

protocol HomeScreenDisplayLogic: AnyObject, BaseViewDisplayLogic {
    func showResultScreenWith(viewModel: HomeScreenViewModel)
    func showNoFoundOrErrorWith(message: String)
}

class HomeScreenViewController: BaseViewController {
    var interactor: HomeScreenBusinessLogic?
    var router: (NSObjectProtocol & HomeScreenRoutingLogic & HomeScreenDataPassing)?

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: Views

    let searchBar: UITextField = {
        let bar = UITextField.init()
        bar.textAlignment = .center
        bar.backgroundColor = Constants.Styles.primaryColor
        bar.textColor = Constants.Styles.backgroundColor
        bar.borderStyle = .line
        bar.placeholder = Constants.HomeScreen.searchFieldPlaceholder

        bar.clipsToBounds = true
        bar.layer.cornerRadius = 5
        bar.layer.borderColor = UIColor.lightGray.cgColor
        bar.layer.borderWidth = 1
        bar.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 36))
        bar.leftViewMode = .always
        bar.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 36))
        bar.rightViewMode = .always
        bar.clearButtonMode = .whileEditing
        return bar
    }()

    let titleLabel: UILabel = {
        let label = UILabel.init()
        label.text = Constants.HomeScreen.titleLabel
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = Constants.Styles.primaryColor
        label.textAlignment = .center
        return label
    }()

    let descLabel: UILabel = {
        let label = UILabel.init()
        label.text = Constants.HomeScreen.descLabel
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = Constants.Styles.secondaryColor
        return label
    }()

    let searchHelpLabel: UILabel = {
        let label = UILabel.init()
        label.text = Constants.HomeScreen.helpLabel
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = Constants.Styles.secondaryColor
        return label
    }()

    let categoriesLabel: UILabel = {
        let label = UILabel.init()
        label.text = Constants.HomeScreen.selectCategories
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = Constants.Styles.primaryColor
        return label
    }()

    let searchButton: UIButton = {
        let button = UIButton.init()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitle(Constants.HomeScreen.search, for: .init())
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .init())
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        return button
    }()

    let categoriesSelectionView: UIView = {
        let view = UIView.init()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        let categories = MediaType.allCases.map({
            $0.rawValue
        })

        let topStack = UIStackView()
        topStack.distribution = .equalSpacing
        topStack.alignment = .fill
        topStack.axis = .horizontal

        let bottomStack = UIStackView()
        bottomStack.distribution = .equalSpacing
        bottomStack.alignment = .fill
        bottomStack.axis = .horizontal

        for (ind, str) in categories.enumerated() {
            let button = UIButton()
            button.tag = ind
            button.setTitle( "  \(str)  ", for: .init())
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.backgroundColor = .white
            button.layer.cornerRadius = 12
            button.clipsToBounds = true
            button.setTitleColor(.gray, for: .init())
            button.addTarget(self, action: #selector(selectCategory), for: .touchUpInside)
            ind < 4 ? topStack.addArrangedSubview(button) : bottomStack.addArrangedSubview(button)
        }

        let categoriesStack = UIStackView()
        categoriesStack.distribution = .fillEqually
        categoriesStack.alignment = .fill
        categoriesStack.spacing = 16
        categoriesStack.axis = .vertical

        categoriesStack.addArrangedSubview(topStack)
        categoriesStack.addArrangedSubview(bottomStack)

        view.addSubview(categoriesStack)
        categoriesStack.snp.makeConstraints({
            $0.edges.equalTo(view)
        })
        return view
    }()

    private func setupViews() {
        self.setupToHideKeyboardOnTapOnView()
        self.view.addSubview(searchBar)
        self.view.addSubview(titleLabel)
        self.view.addSubview(descLabel)
        self.view.addSubview(searchHelpLabel)
        self.view.addSubview(categoriesSelectionView)
        self.view.addSubview(searchButton)
        self.view.addSubview(categoriesLabel)
    }

    private func setupConstraints() {

        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(64)
        }

        descLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(32)
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
        }

        searchBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(36)
            make.top.equalTo(descLabel.snp.bottom).offset(48)
        }

        searchHelpLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(32)
            make.top.equalTo(searchBar.snp.bottom).offset(16)
        }

        categoriesLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(32)
            make.top.equalTo(searchHelpLabel.snp.bottom).offset(42)
        }

        categoriesSelectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(32)
            make.top.equalTo(categoriesLabel.snp.bottom).offset(16)
            make.height.equalTo(4 + (28 * 2) + 4 + 8)
        }

        searchButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(categoriesSelectionView.snp.bottom).offset(56)
        }
    }

    var selectedCategories: [String] = []

    @objc func selectCategory(sender: UIButton) {
        let title = sender.title(for: .init())!
        if selectedCategories.contains(title) {
            sender.backgroundColor = .white
            sender.setTitleColor(.gray, for: .init())
            selectedCategories.removeAll(where: {
                $0 == title
            })
        } else {
            sender.backgroundColor = .gray
            sender.setTitleColor(.white, for: .init())
            selectedCategories.append(title)
        }
    }

    @objc func search(sender: UIButton) {
        showSpinner()
        interactor?.fetchMusic(queryString: searchBar.text, entity: selectedCategories)
    }
}

// MARK: - Display logic implementation

extension HomeScreenViewController: HomeScreenDisplayLogic {

    func showResultScreenWith(viewModel: HomeScreenViewModel) {
        hideSpinner()
        router?.routeToResult()
    }

    func showNoFoundOrErrorWith(message: String) {
        hideSpinner()
        showToast(type: .error, message: message)
    }
}
