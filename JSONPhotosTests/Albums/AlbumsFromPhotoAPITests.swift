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
                        Self.createControlPhoto(withId: 1)
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
                        .map(Self.createControlPhoto))
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
                            Self.createControlPhoto(withId: $0)
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
                        .map(Self.createControlPhoto)),
                Album(
                    id: 2,
                    photos: (5..<10)
                        .map(Self.createControlPhoto)),
                Album(
                    id: 3,
                    photos: (10..<15)
                        .map(Self.createControlPhoto))
            ])
    }

    static func createControlPhoto(
        withId id: Int
    ) -> Photo {
        Photo(
            id: id,
            title: "PhotoAPI Title",
            thumbnail: URL(staticString: "https://www.fixture.com"),
            url: URL(staticString: "https://www.fixture.com"))
    }
}
