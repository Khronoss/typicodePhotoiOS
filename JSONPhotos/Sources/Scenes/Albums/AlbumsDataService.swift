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
        session
            .getData(
                from: URL(staticString: "http://jsonplaceholder.typicode.com/photos"))
            .decode(
                type: [PhotoAPI].self,
                decoder: JSONDecoder())
            .map(
                Album.listFrom(photos:))
            .asObservable()
    }
}
