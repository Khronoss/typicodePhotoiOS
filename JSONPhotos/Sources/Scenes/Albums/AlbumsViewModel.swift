//
//  AlbumsViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation

protocol AlbumsViewModelType {
    func viewLoaded()
}

class AlbumsViewModel {
    let coordinator: AlbumsCoordinatorType
    let dataService: AlbumsDataServiceType

    init(
        coordinator: AlbumsCoordinatorType,
        dataService: AlbumsDataServiceType
    ) {
        self.coordinator = coordinator
        self.dataService = dataService
    }
}

extension AlbumsViewModel: AlbumsViewModelType {
    func viewLoaded() {
        dataService
            .fetchAlbums()
    }
}
