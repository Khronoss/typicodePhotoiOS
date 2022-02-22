//
//  AlbumsDataService.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 21/02/2022.
//

import Foundation
import RxSwift

protocol AlbumsDataServiceType {
    func fetchAlbums() -> Observable<[Album]>
}

class AlbumsDataService {
    let session: APISessionManagerType

    init(
        session: APISessionManagerType
    ) {
        self.session = session
    }
}

extension AlbumsDataService: AlbumsDataServiceType {
    func fetchAlbums() -> Observable<[Album]> {
        Observable
            .just([Album]())
            .asObservable()
    }
}
