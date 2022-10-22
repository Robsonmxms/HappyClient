//
//  TextFieldView.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 21/10/22.
//

import UIKit

class TextFieldView: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyViewCode()

    }

    override func layoutSubviews() {
            super.layoutSubviews()

            for view in subviews {
                if let button = view as? UIButton {
                    button.setImage(
                        button
                            .image(for: .normal)?
                            .withRenderingMode(.alwaysTemplate),
                        for: .normal
                    )
                    button.tintColor = .cyan
                }
            }
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TextFieldView: ViewCodeConfiguration {
    func buildHierarchy() {}

    func setupConstraints() {}

    func configureViews() {
        self.keyboardType = .default
        self.returnKeyType = .done
        self.autocorrectionType = .yes
        self.font = .preferredFont(forTextStyle: .title1)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        self.layer.cornerRadius = 10
        self.clearButtonMode = .whileEditing
        self.contentVerticalAlignment = .center
        self.textColor = .black
        self.backgroundColor = .white
        self.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension TextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let maxLength = 20
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
}
