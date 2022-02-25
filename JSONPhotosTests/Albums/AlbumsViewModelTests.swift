//
//  AlbumsViewModelTests.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 21/02/2022.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import JSONPhotos

class AlbumsViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    var albumsObserver: TestableObserver<AlbumsViewState>!

    override func setUp() {
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        albumsObserver = scheduler.createObserver(AlbumsViewState.self)
    }

    override func tearDown() {
        disposeBag = nil
        scheduler = nil
    }

    func testCallingViewLoadedShouldStartLoadingAlbumsOnce() {
        let serviceMock = AlbumsDataServiceMock()
        let viewModel = AlbumsViewModel(
            coordinator: AlbumsCoordinatorMock(),
            dataService: serviceMock)

        viewModel.viewLoaded.accept(())

        XCTAssertEqual(serviceMock.loadCallCount, 1)
    }

    func testOnNoOpItShouldBeInLoadingState() {
        let serviceMock = AlbumsDataServiceMock()
        let viewModel = AlbumsViewModel(
            coordinator: AlbumsCoordinatorMock(),
            dataService: serviceMock)

        let res = scheduler.start {
            viewModel
                .state
                .asObservable()
        }

        XCTAssertEqual(serviceMock.loadCallCount, 0)
        XCTAssertRecordedElements(
            res.events,
            [
                .loading
            ])
    }

    func testReceivingManyAlbumsShouldSendManyAlbumsState() {
        let albums = [
            Album.fixture(id: 1),
            Album.fixture(id: 2)
        ]

        let dataService = AlbumsDataServiceDummy.albums(albums)
        let viewModel = AlbumsViewModel(
            coordinator: AlbumsCoordinatorMock(),
            dataService: dataService)

        viewModel
            .state
            .bind(to: albumsObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        viewModel.viewLoaded.accept(())

        XCTAssertRecordedElements(
            albumsObserver.events,
            [
                .loading,
                .loaded(albums)
            ])
    }

    func testReceivingErrorShouldSendFailedState() {
        let dataService = AlbumsDataServiceDummy.failing()
        let viewModel = AlbumsViewModel(
            coordinator: AlbumsCoordinatorMock(),
            dataService: dataService)

        viewModel
            .state
            .bind(to: albumsObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        viewModel.viewLoaded.accept(())

        XCTAssertRecordedElements(
            albumsObserver.events,
            [
                .loading,
                .failed
            ])
    }
}
