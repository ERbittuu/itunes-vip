//
//  SearchResultRouter.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

protocol SearchResultRoutingLogic {
    func routeToDetail(with data: MusicResponseModel)
}

protocol SearchResultDataPassing {
    var dataStore: SearchResultDataStore? { get }

    func passDataToDetail(source: MusicResponseModel, destination: inout MusicDetailDataStore)
}

class SearchResultRouter: NSObject, SearchResultRoutingLogic, SearchResultDataPassing {

    weak var viewController: SearchResultViewController?
    var dataStore: SearchResultDataStore?

    func routeToDetail(with data: MusicResponseModel) {
        let detailVC = MusicDetailBuilder.viewController()
        if var movieDetailDS = detailVC.router?.dataStore {
            passDataToDetail(source: data, destination: &movieDetailDS)
        }
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
//
    func passDataToDetail(source: MusicResponseModel, destination: inout MusicDetailDataStore) {
        destination.itemDetail = source
    }

}
