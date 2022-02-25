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
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var retryButton: UIButton!

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

        viewModel
            .viewLoaded
            .accept(())

        tableViewAdapter
            .bind(to: tableView)

        setupBindings()

        title = "All albums"
    }

    private func setupBindings() {
        setupBindingsForState()
        setupTableViewBindings()

        retryButton
            .rx
            .tap
            .bind(to: viewModel.retryTap)
            .disposed(by: disposeBag)
    }

    private func setupBindingsForState() {
        viewModel
            .state
            .compactMap(\.value)
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableViewAdapter.albums)
            .disposed(by: disposeBag)

        viewModel
            .state
            .map(\.hasValue)
            .map { !$0 }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel
            .state
            .map(\.isLoading)
            .map { !$0 }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: loadingView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel
            .state
            .map(\.isFailed)
            .map { !$0 }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: errorView.rx.isHidden)
            .disposed(by: disposeBag)
    }

    private func setupTableViewBindings() {
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
