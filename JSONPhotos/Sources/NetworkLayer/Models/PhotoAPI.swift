//
//  AlbumAPI.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 22/02/2022.
//

import Foundation

struct PhotoAPI: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
