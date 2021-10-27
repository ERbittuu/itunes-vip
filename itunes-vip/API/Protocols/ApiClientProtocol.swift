//
//  ApiClientProtocol.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import Foundation

protocol ApiClientProtocol {
    func makeRequest<T>(route: ApiRouter,
                        responseModel: T.Type,
                        success: @escaping (T) -> Void,
                        failed: @escaping (Error, APIErrorType) -> Void) where T: Decodable
}

protocol ApiServiceProtocol {
    var apiClient: ApiClientProtocol {get}
}
