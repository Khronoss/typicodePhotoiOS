//
//  AlbumsViewController.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import UIKit

class AlbumsViewController: UIViewController {
    let viewModel: AlbumsViewModelType

    init(viewModel: AlbumsViewModelType) {
        self.viewModel = viewModel

        super.init(
            nibName: "AlbumsViewController",
            bundle: Bundle(for: Self.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .lightGray
    }

}
