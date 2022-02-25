//
//  AlbumsDataServiceDummy.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 25/02/2022.
//

import Foundation
import RxSwift
@testable import JSONPhotos

class AlbumsDataServiceDummy {
    let data: () throws -> [Album]

    init(
        data: @escaping () throws -> [Album]
    ) {
        self.data = data
    }
}

extension AlbumsDataServiceDummy: AlbumsDataServiceType {
    func fetchAlbums() -> Observable<[Album]> {
        Observable
            .just(())
            .map(data)
            .asObservable()
    }
}

extension AlbumsDataServiceDummy {
    static func emptyAlbums() -> AlbumsDataServiceDummy {
        AlbumsDataServiceDummy(
            data: { [] })
    }

    static func albums(_ albums: [Album]) -> AlbumsDataServiceDummy {
        AlbumsDataServiceDummy(
            data: { albums })
    }

    static func failing() -> AlbumsDataServiceDummy {
        AlbumsDataServiceDummy(
            data: {
                throw NSError(domain: "test", code: 400, userInfo: nil)
            })
    }
}
