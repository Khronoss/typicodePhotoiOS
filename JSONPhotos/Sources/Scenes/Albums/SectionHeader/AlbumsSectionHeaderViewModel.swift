//
//  AlbumsSectionHeaderViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 24/02/2022.
//

import Foundation
import RxSwift
import RxRelay

protocol AlbumsSectionHeaderViewModelType {
    var title: String { get }

    func didTap()
}

class AlbumsSectionHeaderViewModel {
    let tap = PublishRelay<Album>()

    let album: Album

    init(
        album: Album
    ) {
        self.album = album
    }
}

extension AlbumsSectionHeaderViewModel: AlbumsSectionHeaderViewModelType {
    var title: String {
        "Album #\(album.id) (\(album.photos.count) photos)"
    }

    func didTap() {
        tap.accept(album)
    }
}
