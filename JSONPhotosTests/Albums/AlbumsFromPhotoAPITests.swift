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

    func testSinglePhotoListShouldReturnSingleAlbumWithSinglePhoto() {
        let result = Album
            .listFrom(
                photos: [
                    PhotoAPI
                        .fixture(albumId: 1, id: 1)
                ])

        XCTAssertEqual(
            result,
            [
                Album(
                    id: 1,
                    photos: [
                        Photo(
                            id: 1,
                            title: "PhotoAPI Title",
                            thumbnail: URL(staticString: "https://www.fixture.com"),
                            url: URL(staticString: "https://www.fixture.com"))
                    ])
            ])
    }

    func testMultiplePhotosInSingleAlbumListShouldReturnSingleAlbumWithMultiplePhotos() {
        let result = Album
            .listFrom(
                photos: (0..<5)
                    .map { PhotoAPI.fixture(albumId: 1, id: $0) })

        XCTAssertEqual(
            result,
            [
                Album(
                    id: 1,
                    photos: (0..<5)
                        .map {
                            Photo(
                                id: $0,
                                title: "PhotoAPI Title",
                                thumbnail: URL(staticString: "https://www.fixture.com"),
                                url: URL(staticString: "https://www.fixture.com"))
                        })
            ])
    }

    func testSinglePhotoInMultipleAlbumsListShouldReturnMultipleAlbumsWithSinglePhoto() {
        let result = Album
            .listFrom(
                photos: (0..<5)
                    .map { PhotoAPI.fixture(albumId: $0, id: $0) })

        XCTAssertEqual(
            result,
            (0..<5)
                .map {
                    Album(
                        id: $0,
                        photos: [
                            Photo(
                                id: $0,
                                title: "PhotoAPI Title",
                                thumbnail: URL(staticString: "https://www.fixture.com"),
                                url: URL(staticString: "https://www.fixture.com"))
                        ])
                })
    }

    func testMultiplePhotosInMultipleAlbumsListShouldReturnMultipleAlbumsWithMultiplePhotos() {
        let result = Album
            .listFrom(
                photos: (0..<15)
                    .map { PhotoAPI.fixture(albumId: ($0 / 5) + 1, id: $0) })

        XCTAssertEqual(
            result,
            [
                Album(
                    id: 1,
                    photos: (0..<5)
                        .map {
                            Photo(
                                id: $0,
                                title: "PhotoAPI Title",
                                thumbnail: URL(staticString: "https://www.fixture.com"),
                                url: URL(staticString: "https://www.fixture.com"))
                        }),
                Album(
                    id: 2,
                    photos: (5..<10)
                        .map {
                            Photo(
                                id: $0,
                                title: "PhotoAPI Title",
                                thumbnail: URL(staticString: "https://www.fixture.com"),
                                url: URL(staticString: "https://www.fixture.com"))
                        }),
                Album(
                    id: 3,
                    photos: (10..<15)
                        .map {
                            Photo(
                                id: $0,
                                title: "PhotoAPI Title",
                                thumbnail: URL(staticString: "https://www.fixture.com"),
                                url: URL(staticString: "https://www.fixture.com"))
                        })
            ])
    }
}
