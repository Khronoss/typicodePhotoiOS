//
//  PhotoViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

typealias PhotoState = LoadingState<UIImage>

protocol PhotoViewModelType {
    var title: Observable<String> { get }
    var description: Observable<String> { get }

    func fetchImage() -> Observable<PhotoState>
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

    func fetchImage() -> Observable<PhotoState> {
        let fetchPublisher = session
            .getData(from: photo.url)
            .map {
                UIImage(data: $0)
                    .map(PhotoState.loaded)
                ?? PhotoState.failed
            }
            .catchAndReturn(.failed)

        return Observable
            .merge(
                .just(.loading),
                fetchPublisher
            )
            .asObservable()
    }
}
