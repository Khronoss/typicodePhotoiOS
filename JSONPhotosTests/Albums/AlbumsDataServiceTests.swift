//
//  AlbumsDataServiceTests.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 22/02/2022.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import JSONPhotos

class AlbumsDataServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOnFetchingAlbumsItShouldSendsFetchedAlbums() throws {
        let expectedResult = [
            Album(
                id: 1,
                photos: [
                    Photo(
                        id: 1,
                        title: "accusamus beatae ad facilis cum similique qui sunt",
                        thumbnail: URL(staticString: "https://via.placeholder.com/150/92c952"),
                        url: URL(staticString: "https://via.placeholder.com/600/92c952"))
                ]),
            Album(
                id: 2,
                photos: [
                    Photo(
                        id: 2,
                        title: "reprehenderit est deserunt velit ipsam",
                        thumbnail: URL(staticString: "https://via.placeholder.com/150/771796"),
                        url: URL(staticString: "https://via.placeholder.com/600/771796"))
                ])
        ]

        let sessionMock = APISessionManagerMock(
            responseFromFile: "album_dataService_tests_001")
        let dataService = AlbumsDataService(
            session: sessionMock)

        let result = try dataService
            .fetchAlbums()
            .toBlocking()
            .single()

        XCTAssertEqual(
            result,
            expectedResult
        )
    }
}
