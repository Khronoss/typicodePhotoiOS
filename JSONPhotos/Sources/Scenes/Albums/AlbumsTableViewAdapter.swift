//
//  AlbumsTableViewAdapter.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

protocol AlbumsTableViewAdapterType {
    var albums: BehaviorRelay<[Album]> { get }

    func bind(to tableView: UITableView)
}

class AlbumsTableViewAdapter {
    private static let cellIdentifier = "AlbumCell"

    let albums = BehaviorRelay<[Album]>(value: [])
    private(set) var disposeBag = DisposeBag()

    private func resetDisposeBag() {
        disposeBag = DisposeBag()
    }

    private func registerCells(
        to tableView: UITableView
    ) {
        tableView.register(
            AlbumTableViewCell.self,
            forCellReuseIdentifier: Self.cellIdentifier)
    }
}

extension AlbumsTableViewAdapter: AlbumsTableViewAdapterType {
    func bind(
        to tableView: UITableView
    ) {
        resetDisposeBag()
        registerCells(to: tableView)

        tableView.rowHeight = Constants.GUI.photoCellSize
        tableView.estimatedRowHeight = Constants.GUI.photoCellSize

        albums
            .asDriver(
                onErrorJustReturn: [])
            .drive(
                tableView.rx.items(
                    cellIdentifier: Self.cellIdentifier,
                    cellType: AlbumTableViewCell.self)
            ) { (_, _, _) in
                // setupCell
            }
            .disposed(by: disposeBag)
    }
}
