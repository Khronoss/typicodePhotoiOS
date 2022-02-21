//
//  Photo.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation

struct Photo {
    let id: Int
    let thumbnail: URL
    let url: URL
}

extension Photo: Equatable {
    static func == (
        lhs: Self,
        rhs: Self
    ) -> Bool {
        lhs.id == rhs.id &&
        lhs.thumbnail == rhs.thumbnail &&
        lhs.url == rhs.url
    }
}
