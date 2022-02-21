//
//  Album.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation

struct Album {
    let id: Int
    let photos: [Photo]
}

extension Album: Equatable {
    static func ==(
        lhs: Self,
        rhs: Self
    ) -> Bool {
        lhs.id == rhs.id &&
        lhs.photos == rhs.photos
    }
}
