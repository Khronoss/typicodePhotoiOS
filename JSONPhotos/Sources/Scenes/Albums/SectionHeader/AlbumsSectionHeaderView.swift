//
//  AlbumsSectionHeaderView.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 24/02/2022.
//

import UIKit

class AlbumsSectionHeaderView: UIView {
    weak var titleLabel: UILabel!

    let viewModel: AlbumsSectionHeaderViewModelType

    init(
        viewModel: AlbumsSectionHeaderViewModelType
    ) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        setupView()
        setupTapGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        let titleLabel = createTitleLabel()
        let disclosure = createDisclosureView()

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            disclosure
        ])

        stackView.axis = .horizontal

        encapsulate(
            stackView,
            insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 20)
        )

        backgroundColor = .white
            .withAlphaComponent(0.9)
    }

    private func createTitleLabel() -> UILabel {
        let label = UILabel(frame: .zero)

        label.text = viewModel.title
        label.font = .systemFont(ofSize: 17)
        label.textColor = .link
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        return label
    }

    private func createDisclosureView() -> UIView {
        let label = UILabel(frame: .zero)

        label.text = ">"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .link
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        return label
    }

    private func setupTapGesture() {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTap))

        addGestureRecognizer(gesture)
    }

    @objc private func didTap() {
        viewModel.didTap()
    }
}
