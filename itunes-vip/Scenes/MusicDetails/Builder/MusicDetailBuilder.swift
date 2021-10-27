//
//  MusicDetailBuilder.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

class MusicDetailBuilder {

    class func viewController() -> MusicDetailViewController {
        let viewController = MusicDetailViewController()
        let interactor = MusicDetailInteractor()
        let presenter = MusicDetailPresenter()
        let router = MusicDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        return viewController
    }
}
