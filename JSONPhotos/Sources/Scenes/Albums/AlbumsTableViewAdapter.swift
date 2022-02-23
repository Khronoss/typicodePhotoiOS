//
//  AlbumsTableViewAdapter.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct Section: SectionModelType {
    typealias Item = [Photo]

    var items: [Item]

    let albumID: Album.ID

    init(original: Section, items: [[Photo]]) {
        self.albumID = original.albumID
        self.items = items
    }

    init(from album: Album) {
        albumID = album.id
        items = [album.photos]
    }
}

protocol AlbumsTableViewAdapterType {
    var albums: BehaviorRelay<[Album]> { get }

    var photoSelected: PublishRelay<Photo> { get }

    func bind(to tableView: UITableView)
}

class AlbumsTableViewAdapter {
    typealias DataSourceType = RxTableViewSectionedReloadDataSource<Section>

    private static let cellIdentifier = "AlbumCell"

    let albums = BehaviorRelay<[Album]>(value: [])

    let photoSelected = PublishRelay<Photo>()

    private(set) var disposeBag = DisposeBag()
    private lazy var dataSource: DataSourceType = createDataSource()

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

    private func createDataSource() -> DataSourceType {
        DataSourceType(
            configureCell: { [unowned self] _, tableView, indexPath, item in
                guard
                    let cell = tableView
                        .dequeueReusableCell(
                            withIdentifier: Self.cellIdentifier,
                            for: indexPath)
                        as? AlbumTableViewCell
                else {
                    return UITableViewCell()
                }

                let viewModel = AlbumCellViewModel(photos: item)

                viewModel
                    .photoSelected
                    .bind(to: self.photoSelected)
                    .disposed(by: disposeBag)

                cell.viewModel = viewModel

                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                let section = dataSource[sectionIndex]

                let albumID = section.albumID
                let photosCount = section
                    .items
                    .map(\.count)
                    .reduce(0, +)

                return "Album \(albumID) (\(photosCount) photos)"
            })
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
            .map { $0.map(Section.init(from:)) }
            .asDriver(
                onErrorJustReturn: [])
            .drive(
                tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
