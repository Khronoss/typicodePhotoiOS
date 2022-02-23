//
//  PhotoCellViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

enum PhotoCellState {
    case loading
    case loaded(UIImage)
    case failed

    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }

    var isFailed: Bool {
        if case .failed = self {
            return true
        }
        return false
    }

    var image: UIImage? {
        if case .loaded(let image) = self {
            return image
        }
        return nil
    }
}

protocol PhotoCellViewModelType {
    func fetchImage() -> Observable<PhotoCellState>
}

class PhotoCellViewModel {
    let photo: Photo
    let session: APISessionManagerType

    init(
        photo: Photo,
        session: APISessionManagerType
    ) {
        self.photo = photo
        self.session = session
    }
}

extension PhotoCellViewModel: PhotoCellViewModelType {
    func fetchImage() -> Observable<PhotoCellState> {
        let fetchPublisher = session
            .getData(from: photo.thumbnail)
            .map {
                UIImage(data: $0)
                    .map(PhotoCellState.loaded)
                ?? PhotoCellState.failed
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
