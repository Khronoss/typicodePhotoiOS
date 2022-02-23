//
//  PhotoCollectionViewCell.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var viewModel: PhotoCellViewModelType? {
        didSet {
            if let viewModel = viewModel {
                update(with: viewModel)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupView()
    }

    private func setupView() {
        contentView.backgroundColor = .gray
    }

    private func update(
        with viewModel: PhotoCellViewModelType
    ) {
    }
}
