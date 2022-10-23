//
//  HeaderSectionView.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 23/10/22.
//

import UIKit

class HeaderSectionView: UIView {

    private var isSharingImage: Bool
    private var stack = UIStackView()
    private var title = UILabel()
    var shareButton = UIButton()

    init(frame: CGRect, isSharingImage: Bool) {
        self.isSharingImage = isSharingImage
        super.init(frame: frame)
        applyViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HeaderSectionView: ViewCodeConfiguration {
    func buildHierarchy() {
        stack.addArrangedSubview(title)
        if isSharingImage {
            stack.addArrangedSubview(shareButton)
        }
        self.addSubview(stack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 70),

            stack.widthAnchor.constraint(
                equalTo: self.widthAnchor
            )
        ])
    }

    func configureViews() {
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        let configuration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "square.and.arrow.up.circle.fill")?
            .withTintColor(.cyan, renderingMode: .alwaysOriginal)
            .withConfiguration(configuration)
        shareButton.setImage(image, for: .normal)
        shareButton.translatesAutoresizingMaskIntoConstraints = false

        title.text = isSharingImage ? "Your Meme" : "Community Memes"
        title.textColor = .white
        title.font = .preferredFont(forTextStyle: .largeTitle)
    }
}
