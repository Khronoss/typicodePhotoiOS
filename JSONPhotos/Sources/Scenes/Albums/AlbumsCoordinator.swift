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
        let viewModel = AlbumsViewModel(coordinator: self)
        let controller = AlbumsViewController(viewModel: viewModel)

        window.rootViewController = controller
    }
}

extension AlbumsCoordinator: AlbumsCoordinatorType {

}
