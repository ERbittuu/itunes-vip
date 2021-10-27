//
//  Constant.swift
//  itunes-vip
//
//  Created by Utsav Patel on 16/10/21.
//

import UIKit

struct Constants {

    struct HomeScreen {
        static let titleLabel: String = "title_home".localized()
        static let descLabel: String = "title_desc".localized()
        static let helpLabel: String = "search_help".localized()
        static let search: String = "search".localized()
        static let selectCategories: String = "select_categories".localized()
        static let searchFieldPlaceholder: String = "searchbar_placeholder".localized()

        static let validationSearchString: String = "validation_searchString".localized()
        static let validationCategory: String = "validation_category".localized()
        static let somethingWrong: String = "something_wrong".localized()
    }

    struct SearchResult {
        static let titleLabel: String = "title_result".localized()
        static let gridLabel: String = "grid".localized()
        static let listLabel: String = "list".localized()
    }

    struct MusicDetails {
        static let playVideo: String = "play_video".localized()
        static let price: String = "price".localized()
        static let free: String = "free".localized()
    }

    struct Styles {
        static let primaryColor: UIColor = .white
        static let secondaryColor: UIColor = .lightGray
        static let secondaryDarkColor: UIColor = .lightGray
        static let backgroundColor: UIColor = .black
    }
}
