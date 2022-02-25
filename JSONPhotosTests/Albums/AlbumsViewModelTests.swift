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
        let dataService = AlbumsDataServiceMock()
        let viewModel = AlbumsViewModel(
            coordinator: AlbumsCoordinatorMock(),
            dataService: dataService)

        viewModel.viewLoaded.accept(())

        XCTAssertEqual(dataService.loadCallCount, 1)
    }

    func testOnNoOpItShouldBeInLoadingState() {
        let dataService = AlbumsDataServiceMock()
        let viewModel = AlbumsViewModel(
            coordinator: AlbumsCoordinatorMock(),
            dataService: dataService)

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

    func testReceivingAlbumsShouldSendAlbumsState() {
        let albums = (0..<10)
            .map { Album.fixture(id: $0) }

        let dataService = AlbumsDataServiceMock(
            albums: albums)
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
        let dataService = AlbumsDataServiceMock(
            albums: nil)
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
