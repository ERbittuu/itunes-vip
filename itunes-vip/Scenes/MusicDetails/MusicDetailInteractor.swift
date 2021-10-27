//
//  MovieDetailInteractor.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

protocol MusicDetailBusinessLogic {
    func updateDetail()
}

protocol MusicDetailDataStore {
    var itemDetail: MusicResponseModel! {get set}
}

class MusicDetailInteractor: MusicDetailDataStore {
    var itemDetail: MusicResponseModel!

    var presenter: MusicDetailPresentationLogic?
}

extension MusicDetailInteractor: MusicDetailBusinessLogic {

    func updateDetail() {
        presenter?.present(item: itemDetail)
    }
}
