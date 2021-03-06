//
//  AlbumTableViewCell.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import UIKit
import RxSwift

class AlbumTableViewCell: UITableViewCell {
    weak var collectionView: UICollectionView!

    var viewModel: AlbumCellViewModelType? {
        didSet {
            if let viewModel = viewModel {
                update(with: viewModel)
            }
        }
    }

    let adapter = AlbumCollectionViewDatapter()

    private var disposeBag = DisposeBag()

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }

    private func setupView() {
        selectionStyle = .none

        let collectionView = createCollectionView()
        contentView.encapsulate(collectionView)

        self.collectionView = collectionView

        adapter.bind(to: collectionView)
    }

    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: .defaultAlbumPhotosLayout(
                scrollDirection: .horizontal
            ))

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }

    private func update(
        with viewModel: AlbumCellViewModelType
    ) {
        viewModel
            .photos
            .bind(to: adapter.photos)
            .disposed(by: disposeBag)

        collectionView
            .rx
            .modelSelected(Photo.self)
            .bind(to: viewModel.photoSelected)
            .disposed(by: disposeBag)
    }
}
