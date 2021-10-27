//
//  HomeScreenViewModel.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

class HomeScreenViewModel {

    var musics: [[MusicResponseModel]]
    var types: [String]

    init(musics: [[MusicResponseModel]], types: [String]) {
        self.musics = musics
        self.types = types
    }
}
