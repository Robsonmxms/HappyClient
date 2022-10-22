//
//  FooterSectionView.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 21/10/22.
//

import UIKit

class FooterSectionView: UIView {

    private var stack = UIStackView()
    var diceButton = UIButton()
    var doneButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FooterSectionView: ViewCodeConfiguration {
    func buildHierarchy() {
        stack.addArrangedSubview(diceButton)
        stack.addArrangedSubview(doneButton)
        self.addSubview(stack)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 70),

            stack.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),

            doneButton.widthAnchor.constraint(
                equalToConstant: 50
            )
        ])
    }

    func configureViews() {
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .trailing
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        let configuration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "dice.fill")?
            .withTintColor(.cyan, renderingMode: .alwaysOriginal)
            .withConfiguration(configuration)
        diceButton.setImage(image, for: .normal)
        diceButton.translatesAutoresizingMaskIntoConstraints = false

        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.backgroundColor = .cyan
        doneButton.layer.cornerRadius = 10
        doneButton.translatesAutoresizingMaskIntoConstraints = false
    }
}
