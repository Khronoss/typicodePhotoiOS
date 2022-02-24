//
//  AlbumDetailsViewController.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 24/02/2022.
//

import UIKit

class AlbumDetailsViewController: UIViewController {
    let viewModel: AlbumDetailsViewModelType

    init(
        viewModel: AlbumDetailsViewModelType
    ) {
        self.viewModel = viewModel

        super.init(
            nibName: "AlbumDetailsViewController",
            bundle: Bundle(for: Self.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Album Details"
    }

}
