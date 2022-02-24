//
//  AlbumsViewModel.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation
import RxSwift
import RxRelay

enum AlbumsViewState: Equatable {
    case loading
    case albums([Album])
}

extension AlbumsViewState {
    var albums: [Album]? {
        if case .albums(let albums) = self {
            return albums
        }
        return nil
    }
}

protocol AlbumsViewModelType {
    func viewLoaded()
    func didSelect(photo: Photo)
    func didSelect(album: Album)

    var state: BehaviorRelay<AlbumsViewState> { get }
}

class AlbumsViewModel {
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
    }
}

extension AlbumsViewModel: AlbumsViewModelType {
    func viewLoaded() {
        dataService
            .fetchAlbums()
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .map(AlbumsViewState.albums)
            .bind(to: state)
            .disposed(by: disposeBag)
    }

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
