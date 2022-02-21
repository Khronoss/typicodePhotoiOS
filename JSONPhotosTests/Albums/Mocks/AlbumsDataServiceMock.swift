//
//  AlbumsDataServiceMock.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation
@testable import JSONPhotos

class AlbumsDataServiceMock {
    private(set) var loadCallCount = 0
    let albumsToFetch: [Album]

    init(
        albums: [Album] = []
    ) {
        self.albumsToFetch = albums
    }
}

extension AlbumsDataServiceMock: AlbumsDataServiceType {
    func fetchAlbums() {
        loadCallCount += 1
    }
}
