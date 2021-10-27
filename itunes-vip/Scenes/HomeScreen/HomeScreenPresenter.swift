//
//  HomeScreenPresenter.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

protocol HomeScreenPresentationLogic {
    func presentResultScreenWith(musics: [[MusicResponseModel]], types: [String])
    func presentNoFoundOrErrorWith(message: String)
}

class HomeScreenPresenter: HomeScreenPresentationLogic {

    weak var viewController: HomeScreenDisplayLogic?

    // service success
    func presentResultScreenWith(musics: [[MusicResponseModel]], types: [String]) {
        let successViewModel = HomeScreenViewModel.init(musics: musics, types: types)
        viewController?.showResultScreenWith(viewModel: successViewModel)
    }

    // service error
    func presentNoFoundOrErrorWith(message: String) {
        viewController?.showNoFoundOrErrorWith(message: message)
    }
}
