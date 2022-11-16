//
//  BaseApiRouter.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation
import Alamofire

/// An API router used to construct a `URLRequest` for different endpoints
protocol BaseApiRouter: URLRequestConvertible {
    /// The base URL of the API endpoint
    var baseUrl: URL { get }
    /// The `HTTPMethod` of the API endpoint
    var method: HTTPMethod { get }
    /// The path of the API endpoint
    var path: String { get }
    /// A type used to define how a set of parameters are applied to a `URLRequest` for the API endpoint
    var parameterEncoding: ParameterEncoding { get }
    /// The body of the API endpoint
    var body: [String: Any]? { get }
    /// The query params of the API endpoint
    var queryParams: [String: AnyHashable]? { get }
    /// Timeout for the `URLRequest`
    var timeout: TimeInterval { get }
    /// Any additional headers to add to the URLRequest
    var headers: [String: String]? { get }
}

extension BaseApiRouter {
    var baseUrl: URL {
        URL(string: Constants.Api.BaseUrl)!
    }

    var body: [String: Any]? {
        nil
    }

    var queryParams: [String: AnyHashable]? {
        nil
    }

    var timeout: TimeInterval {
        URLSessionConfiguration.default.timeoutIntervalForRequest
    }

    var headers: [String: String]? {
        nil
    }

    var isAuthenticated: Bool? {
        nil
    }

    var parameterEncoding: ParameterEncoding {
        JSONEncoding.default
    }

    func asURLRequest() throws -> URLRequest {
        // Construct the url
        let url = baseUrl.appendingPathComponent(path)

        // Create URLComponents from the url and add query params
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems = queryParams?.map { URLQueryItem(name: $0.key, value: $0.value.description) }

        // Create the URL request
        var urlRequest = try URLRequest(url: components?.url ?? url, method: method)
        urlRequest.timeoutInterval = timeout

        // Add additional headers to the request if they exist
        headers?.forEach({ key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })

        return try parameterEncoding.encode(urlRequest, with: body)
    }
}
