//
//  LoadingState.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import Foundation

enum LoadingState<Element> {
    case loading
    case loaded(Element)
    case failed
}

extension LoadingState {
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }

    var isFailed: Bool {
        if case .failed = self {
            return true
        }
        return false
    }

    var hasValue: Bool {
        value != nil
    }

    var value: Element? {
        if case .loaded(let value) = self {
            return value
        }
        return nil
    }
}

extension LoadingState: Equatable where Element: Equatable {
    static func == (
        lhs: LoadingState<Element>,
        rhs: LoadingState<Element>
    ) -> Bool {
        switch (lhs, rhs) {
            case (.loading, .loading),
                (.failed, .failed):
                return true

            case (.loaded(let lVal), .loaded(let rVal)):
                return lVal == rVal

            default:
                return false
        }
    }
}
