//
//  CatApi.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation
import Alamofire

/// Represents an API for all cat related endpoints.
/// Only responsible for using ``BaseApi/sessionManager`` to make requests
class CatApi: BaseApi, CatApiInterface {
    func getCats(tags: [String]?, skip: Int, limit: Int) async throws -> [CatModel] {
        let request = CatApiRouter.getCats(tags: tags, skip: skip, limit: limit)
        let response = await sessionManager.request(request)
            .validate()
            .serializingDecodable([CatModel].self)
            .response

        switch response.result {
        case .success(let value):
            return value
        case .failure:
            throw ApiError.errorGettingCats
        }
    }
}
