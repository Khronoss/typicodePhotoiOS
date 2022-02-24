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
    var title: Observable<String> { get }
    var photos: Observable<[Photo]> { get }

    func didSelect(photo: Photo)
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
    var title: Observable<String> {
        Observable
            .just("Album #(\(album.id)")
    }

    var photos: Observable<[Photo]> {
        Observable
            .just(album.photos)
    }

    func didSelect(photo: Photo) {
        coordinator
            .showPhoto(photo)
    }
}
