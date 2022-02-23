//
//  Album.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation

struct Album: Identifiable {
    let id: Int
    let photos: [Photo]

    func append(
        _ photo: Photo
    ) -> Album {
        Album(
            id: id,
            photos: photos + [photo])
    }
}

extension Album: Equatable {
    static func == (
        lhs: Self,
        rhs: Self
    ) -> Bool {
        lhs.id == rhs.id &&
        lhs.photos == rhs.photos
    }
}

extension Album {
    static func listFrom(
        photos: [PhotoAPI]
    ) -> [Album] {
        let albums = photos
            .reduce([Album]()) { albums, photo in
                let album = albums
                    .first(
                        where: { $0.id == photo.albumId })
                ?? Album(
                    id: photo.albumId,
                    photos: [])

                let newAlbum = album
                    .append(
                        Photo(from: photo))

                return albums
                    .filter { $0.id != photo.albumId } + [newAlbum]
            }

        return albums
    }
}
