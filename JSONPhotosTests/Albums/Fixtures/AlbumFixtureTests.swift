//
//  AlbumFixtureTests.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 21/02/2022.
//

import XCTest
@testable import JSONPhotos

class AlbumFixtureTests: XCTestCase {
    func testAlbumFixtureWithIDOnly() {
        let albums = (0..<5)
            .map { Album.fixture(id: $0) }

        XCTAssertEqual(
            albums.map(\.id),
            [0, 1, 2, 3, 4])
        XCTAssertEqual(
            albums.map(\.photos),
            [[], [], [], [], []])
    }
}
