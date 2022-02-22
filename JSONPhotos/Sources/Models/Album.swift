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
        var albums: [Album] = []

        for photo in photos {
            if let album = albums.first(where: { $0.id == photo.albumId }) {
                let newAlbum = album
                    .append(
                        Photo(from: photo))

                albums.removeAll(where: { $0.id == photo.albumId })
                albums.append(newAlbum)
            } else {
                let album = Album(
                    id: photo.albumId,
                    photos: [
                        Photo(from: photo)
                    ])
                albums.append(album)
            }
        }
        return albums
    }
}
