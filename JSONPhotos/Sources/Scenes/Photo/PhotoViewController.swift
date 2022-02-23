//
//  PhotoViewController.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import UIKit

class PhotoViewController: UIViewController {
    let viewModel: PhotoViewModelType

    init(
        viewModel: PhotoViewModelType
    ) {
        self.viewModel = viewModel

        super.init(
            nibName: "PhotoViewController",
            bundle: Bundle(for: Self.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Photo Details"
    }
}
