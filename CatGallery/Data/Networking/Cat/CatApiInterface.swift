//
//  CatApiInterface.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation

protocol CatApiInterface {
    func getCats(tags: [String]?, skip: Int, limit: Int) async throws -> [CatModel]
}
