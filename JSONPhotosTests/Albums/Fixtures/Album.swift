//
//  Album.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation
@testable import JSONPhotos

extension Album {
    static func fixture(
        id: Int,
        photos: [Photo] = []
    ) -> Album {
        Album(
            id: id,
            photos: photos)
    }
}
