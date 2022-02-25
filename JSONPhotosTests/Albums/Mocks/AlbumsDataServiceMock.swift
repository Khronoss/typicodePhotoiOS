//
//  AlbumsDataServiceMock.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation
import RxSwift
@testable import JSONPhotos

class AlbumsDataServiceMock {
    private(set) var loadCallCount = 0
    let albumsToFetch: [Album]?

    init(
        albums: [Album]? = []
    ) {
        self.albumsToFetch = albums
    }
}

extension AlbumsDataServiceMock: AlbumsDataServiceType {
    func fetchAlbums() -> Observable<[Album]> {
        loadCallCount += 1

        return Observable
            .just(albumsToFetch)
            .map { albums in
                guard
                    let albums = albums
                else {
                    throw NSError(domain: "test", code: 400, userInfo: nil)
                }
                return albums
            }
            .asObservable()
    }
}
