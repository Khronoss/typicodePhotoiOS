//
//  AlbumsViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation

protocol AlbumsViewModelType {

}

class AlbumsViewModel {
    let coordinator: AlbumsCoordinatorType

    init(
        coordinator: AlbumsCoordinatorType
    ) {
        self.coordinator = coordinator
    }
}

extension AlbumsViewModel: AlbumsViewModelType {

}
