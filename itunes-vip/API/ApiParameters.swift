//
//  ApiParameters.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import Foundation

internal struct ApiParameters {
    static let requestTimeOut = 4.0
    static let timeOutBetweenRetries = 1.0
    static let validationRange = 200..<300

    struct Search {
        static let term = "term"
        static let entity = "entity"
    }
}
