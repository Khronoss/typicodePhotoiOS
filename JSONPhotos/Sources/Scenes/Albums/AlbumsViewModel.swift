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

protocol AlbumsViewModelType {
    func viewLoaded()

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
            .map(AlbumsViewState.albums)
            .bind(to: state)
            .disposed(by: disposeBag)
    }
}
