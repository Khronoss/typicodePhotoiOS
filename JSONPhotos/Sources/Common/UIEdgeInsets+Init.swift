//
//  UIEdgeInsets+Init.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 25/02/2022.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    init(
        vertical: CGFloat,
        horizontal: CGFloat
    ) {
        self.init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal)
    }
}
