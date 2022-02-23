//
//  PhotoViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import Foundation

protocol PhotoViewModelType {

}

class PhotoViewModel {
    let coordinator: PhotoCoordinatorType
    let photo: Photo

    init(
        coordinator: PhotoCoordinatorType,
        photo: Photo
    ) {
        self.coordinator = coordinator
        self.photo = photo
    }
}

extension PhotoViewModel: PhotoViewModelType {

}
