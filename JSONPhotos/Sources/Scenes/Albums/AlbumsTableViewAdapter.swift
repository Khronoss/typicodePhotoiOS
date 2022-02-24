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

    let album: Album

    init(original: Section, items: [[Photo]]) {
        self.album = original.album
        self.items = items
    }

    init(from album: Album) {
        self.album = album
        self.items = [album.photos]
    }
}

protocol AlbumsTableViewAdapterType {
    var albums: BehaviorRelay<[Album]> { get }

    var photoSelected: PublishRelay<Photo> { get }
    var albumSelected: PublishRelay<Album> { get }

    func bind(to tableView: UITableView)
}

class AlbumsTableViewAdapter: NSObject {
    typealias DataSourceType = RxTableViewSectionedReloadDataSource<Section>

    private static let cellIdentifier = "AlbumCell"

    let albums = BehaviorRelay<[Album]>(value: [])

    let photoSelected = PublishRelay<Photo>()
    let albumSelected = PublishRelay<Album>()

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

        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension AlbumsTableViewAdapter: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let album = dataSource
            .sectionModels[section]
            .album
        let viewModel = AlbumsSectionHeaderViewModel(album: album)
        let header = AlbumsSectionHeaderView(viewModel: viewModel)

        viewModel
            .tap
            .bind(to: albumSelected)
            .disposed(by: disposeBag)

        return header
    }

    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        40
    }

    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        0.1
    }
}
