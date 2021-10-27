//
//  HomeScreenRouter.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

@objc protocol HomeScreenRoutingLogic {
    func routeToResult()
}

protocol HomeScreenDataPassing {
    var dataStore: HomeScreenDataStore? { get }

    func passDataToResultScreen(source: HomeScreenDataStore, destination: inout SearchResultDataStore)
}

class HomeScreenRouter: NSObject, HomeScreenRoutingLogic, HomeScreenDataPassing {

    weak var viewController: HomeScreenViewController?
    var dataStore: HomeScreenDataStore?

    func routeToResult() {
        let movieDetailVC = SearchResultBuilder.viewController()
        if var movieDetailDS = movieDetailVC.router?.dataStore, let searchDataStore = dataStore {
            passDataToResultScreen(source: searchDataStore, destination: &movieDetailDS)
        }
        viewController?.navigationController?.pushViewController(movieDetailVC, animated: true)
    }

    func passDataToResultScreen(source: HomeScreenDataStore, destination: inout SearchResultDataStore) {
        destination.searchedItems = source.matchingItems
        destination.types = source.matchingTypes
    }

}
