//
//  APISessionManagerMock.swift
//  JSONPhotosTests
//
//  Created by Merle Anthony on 22/02/2022.
//

import Foundation
import RxSwift
@testable import JSONPhotos

class APISessionManagerMock {
    var fileURL: URL? {
        Bundle(for: Self.self)
            .url(forResource: jsonFileName, withExtension: "json")
    }

    let jsonFileName: String

    init(
        responseFromFile: String
    ) {
        jsonFileName = responseFromFile
    }
}

extension APISessionManagerMock: APISessionManagerType {
    func getData(
        from url: URL
    ) -> Observable<Data> {
        guard
            let fileURL = self.fileURL
        else {
            preconditionFailure("[APISessionManagerMock]: Could not load file \(jsonFileName) from bundle")
        }

        return Observable
            .just(())
            .map {
                try Data(
                    contentsOf: fileURL)
            }
    }
}
