//
//  AlbumCollectionViewDatapter.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol AlbumCollectionViewDatapterType {
    var photos: BehaviorRelay<[Photo]> { get }

    func bind(to collectionView: UICollectionView)
}

class AlbumCollectionViewDatapter {
    static let cellIdentifier = "PhotoCell"

    let photos = BehaviorRelay<[Photo]>(value: [])

    private(set) var disposeBag = DisposeBag()

    private func resetDisposeBag() {
        disposeBag = DisposeBag()
    }

    private func registerCells(
        to collectionView: UICollectionView
    ) {
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: Self.cellIdentifier)
    }
}

extension AlbumCollectionViewDatapter: AlbumCollectionViewDatapterType {
    func bind(
        to collectionView: UICollectionView
    ) {
        resetDisposeBag()
        registerCells(to: collectionView)

        photos
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
