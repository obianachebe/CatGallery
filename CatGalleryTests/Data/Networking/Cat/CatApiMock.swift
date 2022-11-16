//
//  CatApiMock.swift
//  CatGalleryTests
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation

@testable import CatGallery

class CatApiMock: CatApiInterface {
    var getCatsCalled = false
    var getCatsError: Error?
    var getCatsResponse: [CatModel] = []

    func getCats(tags: [String]?, skip: Int, limit: Int) async throws -> [CatModel] {
        getCatsCalled = true

        if let error = getCatsError {
            throw error
        }
        return getCatsResponse
    }
}
