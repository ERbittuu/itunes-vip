//
//  MovieDetailPresenter.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

protocol MusicDetailPresentationLogic {
    func present(item: MusicResponseModel)
}

class MusicDetailPresenter: MusicDetailPresentationLogic {

    weak var viewController: MusicDetailDisplayLogic?

    func present(item: MusicResponseModel) {
        self.viewController?.displayInfo(viewModel: item)
    }
}
