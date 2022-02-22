//
//  Photo.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation

struct Photo {
    let id: Int
    let title: String
    let thumbnail: URL
    let url: URL
}

extension Photo: Equatable {
    static func == (
        lhs: Self,
        rhs: Self
    ) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.thumbnail == rhs.thumbnail &&
        lhs.url == rhs.url
    }
}

extension Photo {
    init(
        from apiModel: PhotoAPI
    ) {
        id = apiModel.id
        title = apiModel.title
        thumbnail = URL(string: apiModel.thumbnailUrl)!
        url = URL(string: apiModel.url)!
    }
}
