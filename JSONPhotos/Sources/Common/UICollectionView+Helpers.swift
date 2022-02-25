//
//  UICollectionView+Helpers.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 25/02/2022.
//

import Foundation
import UIKit

extension UICollectionView {
    var width: CGFloat {
        let sectionIsets = (collectionViewLayout as? UICollectionViewFlowLayout)?
            .sectionInset ?? .zero

        return frame.width - (sectionIsets.left + sectionIsets.right)
    }
}
