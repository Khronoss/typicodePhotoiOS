//
//  AlbumsViewController.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let disposeBag = DisposeBag()

    let viewModel: AlbumsViewModelType
    let tableViewAdapter: AlbumsTableViewAdapterType

    init(
        viewModel: AlbumsViewModelType,
        tableViewAdapter: AlbumsTableViewAdapterType
    ) {
        self.viewModel = viewModel
        self.tableViewAdapter = tableViewAdapter

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

        viewModel.viewLoaded()
        tableViewAdapter.bind(to: tableView)

        setupBindings()

        title = "All albums"
    }

    private func setupBindings() {
        viewModel
            .state
            .compactMap(\.value)
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableViewAdapter.albums)
            .disposed(by: disposeBag)

        tableViewAdapter
            .photoSelected
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] photo in
                self?.viewModel
                    .didSelect(photo: photo)
            })
            .disposed(by: disposeBag)

        tableViewAdapter
            .albumSelected
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] album in
                self?.viewModel
                    .didSelect(album: album)
            })
            .disposed(by: disposeBag)
    }
}
