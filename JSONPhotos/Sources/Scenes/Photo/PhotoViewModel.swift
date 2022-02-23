//
//  PhotoViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol PhotoViewModelType {
    var title: Observable<String> { get }
    var description: Observable<String> { get }
}

class PhotoViewModel {
    let coordinator: PhotoCoordinatorType
    let photo: Photo
    let session: APISessionManagerType

    init(
        coordinator: PhotoCoordinatorType,
        photo: Photo,
        session: APISessionManagerType
    ) {
        self.coordinator = coordinator
        self.photo = photo
        self.session = session
    }
}

extension PhotoViewModel: PhotoViewModelType {
    var title: Observable<String> {
        Observable
            .just("Photo #\(photo.id)")
    }

    var description: Observable<String> {
        Observable
            .just(photo.title)
    }
}
