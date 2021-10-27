//
//  HomeScreenInteractor.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

protocol HomeScreenBusinessLogic {
    func fetchMusic(queryString: String?, entity: [String])
}

protocol HomeScreenDataStore {
    var matchingItems: [[MusicResponseModel]] { get }
    var matchingTypes: [String] { get }
}

class HomeScreenInteractor: HomeScreenBusinessLogic, HomeScreenDataStore {

    var matchingItems: [[MusicResponseModel]] = []
    var matchingTypes: [String] = []

    var presenter: HomeScreenPresentationLogic?
    var musicService: MusicServiceProtocol?

    init(movieService: MusicServiceProtocol = MusicService.init()) {
        self.musicService = movieService
    }

    func fetchMusic(queryString: String?, entity: [String]) {

        guard let query = queryString else {
            self.presenter?.presentNoFoundOrErrorWith(message: Constants.HomeScreen.validationSearchString)
            return
        }

        let trancateQuery = query.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if trancateQuery.isEmpty {
            self.presenter?.presentNoFoundOrErrorWith(message: Constants.HomeScreen.validationSearchString)
            return
        }

        if entity.isEmpty {
            self.presenter?.presentNoFoundOrErrorWith(message: Constants.HomeScreen.validationCategory)
            return
        }

        self.matchingItems.removeAll()
        self.matchingTypes.removeAll()
        let group = DispatchGroup()

        for item in entity {
            let typeM = item.trimmingCharacters(in: .whitespacesAndNewlines)
            let mediaType = MediaType(rawValue: typeM)!
            group.enter()
            musicService?.searchMovie(query: query,
                                      entity: mediaType.key,
                                      success: { (matchingMusicResponse) in
                guard let music = matchingMusicResponse.results else {
                    group.leave()
                    return
                }
                self.matchingItems.append(music)
                self.matchingTypes.append(typeM)
                group.leave()
            }, failure: { (_, _) in
                group.leave()
            })
        }

        group.notify(queue: DispatchQueue.main) {
            self.matchingItems.isEmpty
            ? self.presenter?.presentNoFoundOrErrorWith(message: Constants.HomeScreen.somethingWrong)
                : self.presenter?.presentResultScreenWith(musics: self.matchingItems, types: self.matchingTypes)
        }
    }
}
