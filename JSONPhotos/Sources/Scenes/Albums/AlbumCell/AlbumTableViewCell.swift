//
//  AlbumTableViewCell.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import UIKit
import RxSwift

class AlbumTableViewCell: UITableViewCell {
    static let cellIdentifier = "PhotoCell"

    weak var collectionView: UICollectionView!

    var viewModel: AlbumCellViewModelType? {
        didSet {
            if let viewModel = viewModel {
                update(with: viewModel)
            }
        }
    }

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
        encapsulate(collectionView)

        self.collectionView = collectionView
    }

    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(
            width: Constants.GUI.photoCellSize,
            height: Constants.GUI.photoCellSize)
        layout.minimumInteritemSpacing = Constants.GUI.collectionsItemSpacing
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)

        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: Self.cellIdentifier)

        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }

    private func encapsulate(
        _ view: UIView
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    private func update(
        with viewModel: AlbumCellViewModelType
    ) {
        viewModel
            .photos
            .asDriver(onErrorJustReturn: [])
            .drive(
                collectionView.rx.items(
                    cellIdentifier: Self.cellIdentifier,
                    cellType: UICollectionViewCell.self)) { (_, _, cell) in
                        cell.backgroundColor = .red
                    }
                    .disposed(by: disposeBag)
    }
}
