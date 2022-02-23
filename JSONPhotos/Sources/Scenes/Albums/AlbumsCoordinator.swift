//
//  AlbumsCoordinator.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation
import UIKit

protocol AlbumsCoordinatorType {

}

class AlbumsCoordinator {
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

        window.rootViewController = controller
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

}
