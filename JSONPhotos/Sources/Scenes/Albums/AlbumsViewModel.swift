//
//  AlbumsViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation
import RxSwift
import RxRelay

typealias AlbumsViewState = LoadingState<[Album]>

protocol AlbumsViewModelType {
    var viewLoaded: PublishRelay<Void> { get }
    var retryTap: PublishRelay<Void> { get }

    func didSelect(photo: Photo)
    func didSelect(album: Album)

    var state: BehaviorRelay<AlbumsViewState> { get }
}

class AlbumsViewModel {
    let viewLoaded = PublishRelay<Void>()
    let retryTap = PublishRelay<Void>()

    let state = BehaviorRelay<AlbumsViewState>(value: .loading)

    private let disposeBag = DisposeBag()

    let coordinator: AlbumsCoordinatorType
    let dataService: AlbumsDataServiceType

    init(
        coordinator: AlbumsCoordinatorType,
        dataService: AlbumsDataServiceType
    ) {
        self.coordinator = coordinator
        self.dataService = dataService

        setupBindings()
    }

    private func setupBindings() {
        Observable
            .merge(
                viewLoaded.asObservable(),
                retryTap.asObservable())
            .flatMap({ [dataService] _ in
                dataService
                    .fetchAlbums()
                    .map(AlbumsViewState.loaded)
                    .catchAndReturn(.failed)
            })
            .bind(to: state)
            .disposed(by: disposeBag)
    }
}

extension AlbumsViewModel: AlbumsViewModelType {
    func didSelect(
        photo: Photo
    ) {
        coordinator
            .showPhoto(photo)
    }

    func didSelect(
        album: Album
    ) {
        coordinator
            .showAlbum(album)
    }
}
