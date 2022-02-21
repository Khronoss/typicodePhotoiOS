//
//  AlbumsViewModelTests.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 21/02/2022.
//

import XCTest
@testable import JSONPhotos

class AlbumsViewModelTests: XCTestCase {

    func testCallingViewLoadedShouldStartLoadingAlbumsOnce() {
        let dataService = AlbumsDataServiceMock()
        let viewModel = AlbumsViewModel(
            coordinator: AlbumsCoordinatorMock(),
            dataService: dataService)

        viewModel.viewLoaded()

        XCTAssertEqual(dataService.loadCallCount, 1)
    }
}
