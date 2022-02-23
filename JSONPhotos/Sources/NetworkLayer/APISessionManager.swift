//
//  APISessionManager.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 22/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol APISessionManagerType {
    func getData(from url: URL) -> Observable<Data>
}

extension URLSession: APISessionManagerType {
    func getData(
        from url: URL
    ) -> Observable<Data> {
        let request = URLRequest(url: url)

        return Reactive(self)
            .response(request: request)
            .map(CachedURLResponse.init)
            .do(onNext: { [unowned self] response in
                self
                    .configuration
                    .urlCache?
                    .storeCachedResponse(
                        response,
                        for: request)
            })
            .catch({ [unowned self] error in
                Observable
                    .just(())
                    .map {
                        guard
                            let cachedResponse = self
                                .configuration
                                .urlCache?
                                .cachedResponse(for: request)
                        else {
                            throw error
                        }
                        return cachedResponse
                    }
            })
            .map(\.data)
    }
}
