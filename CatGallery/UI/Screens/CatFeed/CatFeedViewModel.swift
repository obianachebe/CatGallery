//
//  CatFeedViewModel.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation
import SwiftUI

@MainActor
class CatFeedViewModel: ObservableObject {
    @Published var isLoading = false

    @Published var cats: [CatModel] = []
    @Published var error: Error?
    @Published var alert: BaseAlert?

    private let catApi: CatApiInterface

    /// Creates a cat feed view model
    /// - Parameters:
    ///   - catApi: A ``CatApi`` to fetch cats
    init(catApi: CatApiInterface = CatApi()) {
        self.catApi = catApi
    }

    func getCats(skip: Int, limit: Int) async {
        // Show loading spinner when fetching
        isLoading = true

        do {
            // Get the next page of cats from the API
            let nextCats = try await catApi.getCats(
                tags: nil,
                skip: skip,
                limit: limit
            )
            // Add the next page of cats to the list of cats
            cats.append(contentsOf: nextCats)

            isLoading = false
        } catch {
            self.error = error
            handleError(error: error)

            isLoading = false
        }
    }

    /// Handles a generic error and maps it to an alert if it is a BaseError
    /// - Parameters:
    ///   - error: The error to handle
    /// - Returns: A Bool indicating whether or not the error was handled
    @discardableResult
    private func handleError(error: Error) -> Bool {
        if let error = error as? BaseError {
            let action: Alert.Button = .default(Text(Strings.Shared.ok), action: { [weak self] in
                self?.alert = nil
                self?.error = nil
            })
            alert = BaseAlert(error: error, primaryAction: action)

            return true
        } else {
            return false
        }
    }
}
