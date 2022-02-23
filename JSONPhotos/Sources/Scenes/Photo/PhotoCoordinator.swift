//
//  PhotoCoordinator.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import Foundation
import UIKit

protocol PhotoCoordinatorType {

}

class PhotoCoordinator {
    unowned let sourceController: UIViewController
    let photo: Photo

    init(
        sourceController: UIViewController,
        photo: Photo
    ) {
        self.sourceController = sourceController
        self.photo = photo
    }

    func start() {
        let viewModel = PhotoViewModel(
            coordinator: self,
            photo: photo)
        let controller = PhotoViewController(
            viewModel: viewModel)

        sourceController.show(
            controller,
            sender: self)
    }
}

extension PhotoCoordinator: PhotoCoordinatorType {

}
