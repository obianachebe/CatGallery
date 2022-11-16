//
//  CatApiRouter.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation
import Alamofire

/// An API router for cat related endpoints
enum CatApiRouter: BaseApiRouter {
    case getCats(tags: [String]?, skip: Int, limit: Int)

    var method: HTTPMethod {
        switch self {
        case .getCats:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getCats:
            return "/api/cats"
        }
    }

    var queryParams: [String: AnyHashable]? {
        switch self {
        case .getCats(let tags, let skip, let limit):
            var query: [String: AnyHashable] = [
                "skip": skip,
                "limit": limit
            ]
            if let tags = tags {
                query["tags"] = tags.joined(separator: ",")
            }

            return query
        }
    }
}
