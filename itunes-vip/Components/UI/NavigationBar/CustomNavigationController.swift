//
//  CustomNavigationController.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        setupStyle()
    }

    private func setupStyle() {
        self.navigationBar.barStyle = .black
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = Constants.Styles.primaryColor
        let textAttributes = [NSAttributedString.Key.foregroundColor: Constants.Styles.primaryColor]
        self.navigationBar.titleTextAttributes = textAttributes
    }

}
