//
//  ApiRouter.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import Foundation
import Alamofire

// enum to organize all the info needed to perform every call of the app

internal enum ApiRouter {
    case searchMusic(term: String, entity: String)
}

extension ApiRouter: URLRequestConvertible {

    var method: HTTPMethod {
        switch self {
        case .searchMusic:
            return .get
        }
    }

    var path: String {
        switch self {
        case .searchMusic:
            return ApiEndpoints.SearchPath.musicSearch
        }
    }

    var parameters: Parameters? {
        switch self {
        case .searchMusic(let term, let entity):
            return [ApiParameters.Search.term: term,
                    ApiParameters.Search.entity: entity]
        }
    }

    func asURLRequest() throws -> URLRequest {

        var urlRequest: URLRequest

        let url = try ApiEndpoints.BaseURL.itunesBaseUrl.asURL()

        // Create urlRequest
        urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // Set method
        urlRequest.httpMethod = method.rawValue

        urlRequest.cachePolicy = .reloadIgnoringCacheData
        // Set parameters
        urlRequest = try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)

        // Set max timeout time
        urlRequest.timeoutInterval = ApiParameters.requestTimeOut

        return urlRequest
    }

}
