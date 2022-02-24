//
//  AlbumsCoordinator.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation
import UIKit

protocol AlbumsCoordinatorType {
    func showPhoto(_ photo: Photo)
    func showAlbum(_ album: Album)
}

class AlbumsCoordinator {
    weak var controller: UIViewController!

    unowned let window: UIWindow

    init(
        from window: UIWindow
    ) {
        self.window = window
    }

    func start() {
        let viewModel = createAlbumsViewModel()
        let tableViewAdapter = AlbumsTableViewAdapter()
        let controller = AlbumsViewController(
            viewModel: viewModel,
            tableViewAdapter: tableViewAdapter)

        let navController = UINavigationController(
            rootViewController: controller)

        window.rootViewController = navController
        self.controller = controller
    }

    func createAlbumsViewModel() -> AlbumsViewModelType {
        let dataService = AlbumsDataService(
            session: URLSession.shared)

        return AlbumsViewModel(
            coordinator: self,
            dataService: dataService)
    }
}

extension AlbumsCoordinator: AlbumsCoordinatorType {
    func showPhoto(_ photo: Photo) {
        let coordinator = PhotoCoordinator(
            sourceController: controller,
            photo: photo)

        coordinator.start()
    }

    func showAlbum(_ album: Album) {
        let coordinator = AlbumDetailsCoordinator(
            sourceController: controller,
            album: album)

        coordinator.start()
    }
}
