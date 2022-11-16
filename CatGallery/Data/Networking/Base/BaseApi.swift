//
//  BaseApi.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation
import Alamofire

/// `BaseApi` holds the Alamofire `Session` responsible for making API requests.
class BaseApi {
    let sessionManager: Session

    init(
        sessionManager: Session = Session(
            configuration: URLSessionConfiguration.af.default,
            eventMonitors: [BaseNetworkLogger()]
        )
    ) {
        self.sessionManager = sessionManager
    }
}
