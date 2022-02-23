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

    init(
        photo: Photo
    ) {
        self.photo = photo
    }
}

extension PhotoCellViewModel: PhotoCellViewModelType {
    func fetchImage() -> Observable<PhotoCellState> {
        Observable
            .merge(
                .just(.loading),
                .just(.failed)
                    .delay(
                        .seconds(5),
                        scheduler: MainScheduler.asyncInstance)
            )
            .asObservable()
    }
}
