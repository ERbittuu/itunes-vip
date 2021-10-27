//
//  MovieSearchPresenter.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

protocol SearchResultPresentationLogic {
    func showResult(items: [[MusicResponseModel]], types: [String])
}

class SearchResultPresenter: SearchResultPresentationLogic {

    weak var viewController: SearchResultDisplayLogic?
    func showResult(items: [[MusicResponseModel]], types: [String]) {
        self.viewController?.showResult(items: items, types: types)
    }
}
