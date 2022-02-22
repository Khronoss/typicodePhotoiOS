//
//  URL+StaticString.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 22/02/2022.
//

import Foundation

extension URL {
    init(
        staticString: StaticString
    ) {
        guard let url = URL(string: "\(staticString)") else {
            preconditionFailure("Invalid static URL string: \(staticString)")
        }

        self = url
    }
}
