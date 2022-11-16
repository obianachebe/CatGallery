//
//  CatFeedViewModelTests.swift
//  CatGalleryTests
//
//  Created by Obiora Anachebe on 11/15/22.
//

import XCTest
import Combine

@testable import CatGallery

final class CatFeedViewModelTests: XCTestCase {
    var sut: CatFeedViewModel!
    var catApiMock: CatApiMock!
    var subscriptions: Set<AnyCancellable> = []

    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()

        catApiMock = CatApiMock()
        sut = CatFeedViewModel(catApi: catApiMock)
    }

    @MainActor func test_when_cats_fetched_api_called() async throws {
        // When
        await sut.getCats(skip: 0, limit: 10)

        // Then
        XCTAssertTrue(catApiMock.getCatsCalled)
    }

    @MainActor func test_when_cats_fetched_loading_spinner_shown() async throws {
        let expectation = expectation(description: "Expect isLoading to be true")
        sut.$isLoading
            .first(where: { $0 })
            .sink { value in
                XCTAssertTrue(value)
                expectation.fulfill()
            }.store(in: &subscriptions)

        // When
        await sut.getCats(skip: 0, limit: 10)

        // Then
        wait(for: [expectation], timeout: 5)
    }

    func test_when_get_cats_error_thrown_alert_shown() async throws {
        // Given
        let error = ApiError.errorGettingCats
        catApiMock.getCatsError = error

        // When
        await sut.getCats(skip: 0, limit: 10)

        let alert = await sut.$alert
            .first()
            .values
            .first(where: { _ in true }) ?? nil

        // Then
        XCTAssertEqual(alert?.message, error.message)
    }
}
