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
        Reactive(self)
            .data(request: URLRequest(url: url))
    }
}
