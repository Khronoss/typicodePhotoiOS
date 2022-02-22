//
//  AlbumsFromPhotoAPITests.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 22/02/2022.
//

import XCTest
@testable import JSONPhotos

class AlbumsFromPhotoAPITests: XCTestCase {

    func testEmptyPhotosListShouldReturnEmptyAlbumList() {
        let result = Album
            .listFrom(
                photos: [])

        XCTAssertEqual(
            result,
            [])
    }


    }
}
