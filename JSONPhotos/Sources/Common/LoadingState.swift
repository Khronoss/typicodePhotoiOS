//
//  LoadingState.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import Foundation

enum LoadingState<T> {
    case loading
    case loaded(T)
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

    var value: T? {
        if case .loaded(let value) = self {
            return value
        }
        return nil
    }
}
