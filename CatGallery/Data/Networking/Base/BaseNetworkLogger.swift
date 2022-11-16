//
//  BaseNetworkLogger.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation
import Alamofire

class BaseNetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: BuildConfig.bundleId ?? "network-logger-queue")

    func requestDidFinish(_ request: Request) {
        print(request.description)
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            print(json)
        }
    }
}
