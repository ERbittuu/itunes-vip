//
//  BaseViewController.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit
import ProgressHUD
import Loaf

protocol BaseViewDisplayLogic {

}

class BaseViewController: UIViewController, BaseViewDisplayLogic {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Constants.Styles.backgroundColor
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func showSpinner() {
        ProgressHUD.show("Loading")
    }

    func hideSpinner() {
        ProgressHUD.dismiss()
    }

    func showToast(type: Loaf.State, message: String) {
        Loaf.dismiss(sender: self, animated: false)
        Loaf(message,
             state: type,
             location: .top,
             presentingDirection: .left,
             dismissingDirection: .right,
             sender: self).show()
    }
}
