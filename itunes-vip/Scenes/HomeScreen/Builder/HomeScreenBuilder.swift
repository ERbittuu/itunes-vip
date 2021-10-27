//
//  HomeScreenBuilder.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import Foundation

class HomeScreenBuilder {

    class func viewController() -> HomeScreenViewController {
        let viewController = HomeScreenViewController()
        let interactor = HomeScreenInteractor()
        let presenter = HomeScreenPresenter()
        let router = HomeScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
