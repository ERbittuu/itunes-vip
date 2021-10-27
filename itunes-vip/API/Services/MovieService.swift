//
//  MovieService.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import Foundation

protocol MusicServiceProtocol: ApiServiceProtocol {
    func searchMovie(query: String,
                     entity: String,
                     success: @escaping (SearchResultResponseModel) -> Void,
                     failure: @escaping(FailureCompletion))
}

class MusicService: MusicServiceProtocol {

    let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol = ApiClient.shared) {
        self.apiClient = apiClient
    }

    func searchMovie(query: String,
                     entity: String,
                     success: @escaping (SearchResultResponseModel) -> Void,
                     failure: @escaping(FailureCompletion)) {
        apiClient.makeRequest(route: .searchMusic(term: query, entity: entity),
                              responseModel: SearchResultResponseModel.self,
                              success: success,
                              failed: failure)
    }
}
