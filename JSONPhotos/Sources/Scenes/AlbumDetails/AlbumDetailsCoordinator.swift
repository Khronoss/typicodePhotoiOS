//
//  AlbumDetailsCoordinator.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 24/02/2022.
//

import Foundation
import UIKit

protocol AlbumDetailsCoordinatorType {
    func showPhoto(_ photo: Photo)
}

class AlbumDetailsCoordinator {
    weak var controller: UIViewController!

    unowned let sourceController: UIViewController
    let album: Album

    init(
        sourceController: UIViewController,
        album: Album
    ) {
        self.sourceController = sourceController
        self.album = album
    }

    func start() {
        let viewModel = AlbumDetailsViewModel(
            coordinator: self,
            album: album)
        let controller = AlbumDetailsViewController(
            viewModel: viewModel,
            collectionViewAdapter: AlbumCollectionViewDatapter())

        sourceController.show(controller, sender: self)

        self.controller = controller
    }
}

extension AlbumDetailsCoordinator: AlbumDetailsCoordinatorType {
    func showPhoto(_ photo: Photo) {
        let coordinator = PhotoCoordinator(
            sourceController: controller,
            photo: photo)

        coordinator.start()
    }
}
