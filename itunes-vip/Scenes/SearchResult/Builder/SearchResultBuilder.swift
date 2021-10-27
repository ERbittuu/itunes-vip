//
//  SearchResultBuilder.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

class SearchResultBuilder {

    class func viewController() -> SearchResultViewController {
        let viewController = SearchResultViewController()
        let interactor = SearchResultInteractor()
        let presenter = SearchResultPresenter()
        let router = SearchResultRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
