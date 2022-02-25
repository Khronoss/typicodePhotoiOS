//
//  AlbumsCoordinatorMock.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation
@testable import JSONPhotos

class AlbumsCoordinatorMock: AlbumsCoordinatorType {
    func showPhoto(_ photo: Photo) {}

    func showAlbum(_ album: Album) {}
}
