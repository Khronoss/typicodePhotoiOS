//
//  AlbumDetailsViewController.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 24/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumDetailsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    private let disposeBag = DisposeBag()

    let viewModel: AlbumDetailsViewModelType
    let collectionViewAdapter: AlbumCollectionViewDatapterType

    init(
        viewModel: AlbumDetailsViewModelType,
        collectionViewAdapter: AlbumCollectionViewDatapterType
    ) {
        self.viewModel = viewModel
        self.collectionViewAdapter = collectionViewAdapter

        super.init(
            nibName: "AlbumDetailsViewController",
            bundle: Bundle(for: Self.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Album Details"

        collectionView.collectionViewLayout = collectionViewLayout()

        setupBindings()
    }

    private func setupBindings() {
        collectionViewAdapter.bind(to: collectionView)

        viewModel
            .photos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: collectionViewAdapter.photos)
            .disposed(by: disposeBag)

        viewModel
            .title
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: rx.title)
            .disposed(by: disposeBag)
        
        collectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        collectionView
            .rx
            .modelSelected(Photo.self)
            .bind(onNext: { [weak self] in
                self?.viewModel
                    .didSelect(photo: $0)
            })
            .disposed(by: disposeBag)
    }

    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()

        layout.itemSize = CGSize(
            width: Constants.GUI.collectionsItemSpacing,
            height: Constants.GUI.collectionsItemSpacing)
        layout.minimumInteritemSpacing = Constants.GUI.collectionsItemSpacing
        layout.scrollDirection = .vertical

        return layout
    }
}

extension AlbumDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellsPerRow = 3
        let width = collectionView.frame.width
        let totalSpacing = Constants.GUI.collectionsItemSpacing * CGFloat(cellsPerRow - 1)
        let itemSize = floor((width - totalSpacing) / CGFloat(cellsPerRow))

        return CGSize(
            width: itemSize,
            height: itemSize)
    }
}
