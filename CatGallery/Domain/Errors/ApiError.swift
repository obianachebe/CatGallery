//
//  ApiError.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation

enum ApiError: BaseError {
    case errorGettingCats

    var title: String? {
        switch self {
        case .errorGettingCats:
            return Strings.CatFeed.errorTitleErrorGettingCats
        }
    }

    var message: String? {
        switch self {
        case .errorGettingCats:
            return Strings.CatFeed.errorMessageErrorGettingCats
        }
    }
}
