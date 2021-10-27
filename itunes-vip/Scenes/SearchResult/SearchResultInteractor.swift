//
//  MovieSearchInteractor.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

protocol SearchResultBusinessLogic {
    func updateMusic()
}

protocol SearchResultDataStore {
    var searchedItems: [[MusicResponseModel]] { get set }
    var types: [String] { get set }
}

class SearchResultInteractor: SearchResultBusinessLogic, SearchResultDataStore {

    var searchedItems: [[MusicResponseModel]] = []
    var types: [String] = []

    var presenter: SearchResultPresentationLogic?

    func updateMusic() {
        self.presenter?.showResult(items: searchedItems, types: types)
    }
}
