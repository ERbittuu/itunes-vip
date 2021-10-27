//
//  MovieListResponseModel.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import Foundation

struct SearchResultResponseModel: Codable {
    let resultCount: Int?
    let results: [MusicResponseModel]?

    enum CodingKeys: String, CodingKey {

        case resultCount
        case results
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try values.decodeIfPresent(Int.self, forKey: .resultCount)
        results = try values.decodeIfPresent([MusicResponseModel].self, forKey: .results)
    }

}
