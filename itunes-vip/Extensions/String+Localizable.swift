//
//  String+Localizable.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
