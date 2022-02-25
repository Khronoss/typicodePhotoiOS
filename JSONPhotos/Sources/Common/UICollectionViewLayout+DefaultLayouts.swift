//
//  UICollectionViewLayout+DefaultLayouts.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 25/02/2022.
//

import Foundation
import UIKit

extension UICollectionViewLayout {
    static func defaultAlbumPhotosLayout(
        scrollDirection: UICollectionView.ScrollDirection
    ) -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()

        layout.itemSize = CGSize(
            width: Constants.GUI.photoCellSize,
            height: Constants.GUI.photoCellSize)
        layout.minimumInteritemSpacing = Constants.GUI.collectionsItemSpacing
        layout.scrollDirection = scrollDirection
        layout.sectionInset = UIEdgeInsets(
            vertical: 0,
            horizontal: Constants.GUI.collectionsHorizontalMargins)

        return layout
    }
}
