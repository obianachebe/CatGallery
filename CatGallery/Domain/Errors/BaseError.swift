//
//  BaseError.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation

protocol BaseError: LocalizedError {
    var title: String? { get }

    var message: String? { get }
}
