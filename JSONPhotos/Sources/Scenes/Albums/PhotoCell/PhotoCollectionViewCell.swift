//
//  PhotoCollectionViewCell.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    static var nib: UINib {
        UINib(
            nibName: "PhotoCollectionViewCell",
            bundle: Bundle(for: PhotoCollectionViewCell.self))
    }

    var viewModel: PhotoCellViewModelType? {
        didSet {
            if let viewModel = viewModel {
                update(with: viewModel)
            }
        }
    }

    private var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    private func setupView() {
        contentView.backgroundColor = .gray
    }

    private func update(
        with viewModel: PhotoCellViewModelType
    ) {
        let imagePublisher = Observable
            .just(())
            .flatMap(viewModel.fetchImage)
            .share()
            .asDriver(onErrorJustReturn: .failed)

        imagePublisher
            .map(\.isLoading)
            .drive(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.loadingView.startAnimating()
                } else {
                    self?.loadingView.stopAnimating()
                }
                self?.imageView.isHidden = true
            })
            .disposed(by: disposeBag)

        imagePublisher
            .compactMap(\.image)
            .drive(onNext: { [weak self] image in
                self?.imageView.image = image
                self?.imageView.isHidden = false
            })
            .disposed(by: disposeBag)
    }
}
