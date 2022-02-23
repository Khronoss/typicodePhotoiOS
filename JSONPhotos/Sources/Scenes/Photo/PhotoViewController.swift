//
//  PhotoViewController.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    private let disposeBag = DisposeBag()

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
        setupBindings()
    }

    private func setupBindings() {
        viewModel
            .title
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: rx.title)
            .disposed(by: disposeBag)

        viewModel
            .description
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
