//
//  AlbumDetailsViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 24/02/2022.
//

import Foundation

protocol AlbumDetailsViewModelType {

}

class AlbumDetailsViewModel {
    let coordinator: AlbumDetailsCoordinatorType
    let album: Album

    init(
        coordinator: AlbumDetailsCoordinatorType,
        album: Album
    ) {
        self.coordinator = coordinator
        self.album = album
    }
}

extension AlbumDetailsViewModel: AlbumDetailsViewModelType {

}
