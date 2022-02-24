//
//  AlbumDetailsCoordinator.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 24/02/2022.
//

import Foundation
import UIKit

protocol AlbumDetailsCoordinatorType {

}

class AlbumDetailsCoordinator {
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
            viewModel: viewModel)

        sourceController.show(controller, sender: self)
    }
}

extension AlbumDetailsCoordinator: AlbumDetailsCoordinatorType {

}
