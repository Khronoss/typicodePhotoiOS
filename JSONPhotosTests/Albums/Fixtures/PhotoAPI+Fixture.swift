//
//  PhotoAPI.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 22/02/2022.
//

import Foundation
@testable import JSONPhotos

extension PhotoAPI {
    static func fixture(
        albumId: Int,
        id: Int,
        title: String = "PhotoAPI Title",
        url: String = "https://www.fixture.com",
        thumbnailUrl: String = "https://www.fixture.com"
    ) -> PhotoAPI {
        PhotoAPI(
            albumId: albumId,
            id: id,
            title: title,
            url: url,
            thumbnailUrl: thumbnailUrl)
    }
}
