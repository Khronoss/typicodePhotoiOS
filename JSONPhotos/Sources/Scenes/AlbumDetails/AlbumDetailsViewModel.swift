//
//  AlbumDetailsViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 24/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol AlbumDetailsViewModelType {
    var photos: Observable<[Photo]> { get }
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
    var photos: Observable<[Photo]> {
        Observable
            .just(album.photos)
    }
}
