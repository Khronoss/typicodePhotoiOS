//
//  UIView+EncapsulateView.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 23/02/2022.
//

import UIKit

extension UIView {
    func encapsulate(
        _ view: UIView,
        insets: UIEdgeInsets = .zero
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false

        addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
        ])
    }
}
