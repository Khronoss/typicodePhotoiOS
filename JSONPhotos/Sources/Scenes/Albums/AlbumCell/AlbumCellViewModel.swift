//
//  AlbumCellViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol AlbumCellViewModelType {
    var photos: Observable<[Photo]> { get }

    var photoSelected: PublishRelay<Photo> { get }
}

class AlbumCellViewModel {
    let photos: Observable<[Photo]>
    let photoSelected = PublishRelay<Photo>()

    init(
        photos: [Photo]
    ) {
        self.photos = Observable
            .just(photos)
            .asObservable()
    }
}

extension AlbumCellViewModel: AlbumCellViewModelType {

}
