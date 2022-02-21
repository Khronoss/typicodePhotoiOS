//
//  AlbumsViewModelTests.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 21/02/2022.
//

import XCTest
import RxTest
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

    func testOnNoOpItShouldBeInLoadingState() {
        let dataService = AlbumsDataServiceMock()
        let viewModel = AlbumsViewModel(
            coordinator: AlbumsCoordinatorMock(),
            dataService: dataService)

        let scheduler = TestScheduler(initialClock: 0)

        let res = scheduler.start {
            viewModel
                .state
                .asObservable()
        }

        XCTAssertRecordedElements(
            res.events,
            [
                .loading
            ])
    }

}
