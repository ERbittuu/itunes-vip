//
//  MovieDetailRouter.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

@objc protocol MusicDetailRoutingLogic {
  // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MusicDetailDataPassing {
  var dataStore: MusicDetailDataStore? { get }
}

class MusicDetailRouter: NSObject, MusicDetailRoutingLogic, MusicDetailDataPassing {
  weak var viewController: MusicDetailViewController?
  var dataStore: MusicDetailDataStore?

  // MARK: Routing

  // MARK: Navigation

  // MARK: Passing data
}
