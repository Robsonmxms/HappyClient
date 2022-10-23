//
//  UserMemeTableViewCell.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 21/10/22.
//

import UIKit
import CoreData

class UserMemeTableViewCell: UITableViewCell {

    private let placeHolder = UIImage(named: "ImageError")

    private var background = UIView()
    private var imageFromAPI = UIImageView()
    var topTextField = TextFieldView()
    var bottomTextField = TextFieldView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UserMemeTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        background.addSubview(topTextField)
        background.addSubview(imageFromAPI)
        background.addSubview(bottomTextField)
        contentView.addSubview(background)
    }

    func setupConstraints() {
        setupBackgroundConstraints()
        setupTopTextFieldConstraints()
        setupImageFromAPIConstraints()
        setupBottomTextFieldConstraints()
    }

    func configureViews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear

        background.backgroundColor = .white
        background.layer.cornerRadius = 20

        background.translatesAutoresizingMaskIntoConstraints = false

        imageFromAPI.contentMode = .scaleAspectFill
        imageFromAPI.clipsToBounds = true
        imageFromAPI.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupBackgroundConstraints() {
        NSLayoutConstraint.activate([
            background.heightAnchor.constraint(
                equalToConstant: 450
            ),
            background.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            background.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -25
            ),
            background.widthAnchor.constraint(
                equalTo: contentView.widthAnchor
            ),
            background.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            )
        ])
    }

    func setupTopTextFieldConstraints() {
        NSLayoutConstraint.activate([
            topTextField.widthAnchor.constraint(
                equalTo: background.widthAnchor,
                multiplier: 0.9
            ),
            topTextField.topAnchor.constraint(
                equalTo: background.topAnchor,
                constant: 20
            ),
            topTextField.centerXAnchor.constraint(
                equalTo: background.centerXAnchor
            )
        ])
    }

    func setupImageFromAPIConstraints() {
        NSLayoutConstraint.activate([
            imageFromAPI.centerXAnchor.constraint(
                equalTo: background.centerXAnchor
            ),
            imageFromAPI.centerYAnchor.constraint(
                equalTo: background.centerYAnchor
            ),
            imageFromAPI.widthAnchor.constraint(
                equalTo: background.widthAnchor
            ),
            imageFromAPI.heightAnchor.constraint(
                equalToConstant: ScreenSize.width*0.6
            )
        ])
    }

    func setupBottomTextFieldConstraints() {
        NSLayoutConstraint.activate([
            bottomTextField.widthAnchor.constraint(
                equalTo: background.widthAnchor,
                multiplier: 0.9
            ),
            bottomTextField.bottomAnchor.constraint(
                equalTo: background.bottomAnchor,
                constant: -20
            ),
            bottomTextField.centerXAnchor.constraint(
                equalTo: background.centerXAnchor
            )
        ])
    }

    func configure(
        userMeme: NSManagedObject?,
        imageURL: String,
        isRandomImage: Bool
    ) {
        let topSentence = userMeme?.value(forKey: "topSentence") as? String ?? ""

        let bottomSentence = userMeme?.value(forKey: "bottomSentence") as? String ?? ""

        let imageCoreData = userMeme?.value(
            forKey: "imageURL"
        ) as? String ?? "http://imgflip.com/s/meme/Grumpy-Cat.jpg"

        imageFromAPI.imageFromServerURL(
            isRandomImage ? imageURL : imageCoreData,
            placeHolder: placeHolder
        )

        topTextField.attributedPlaceholder = NSAttributedString(
            string: topSentence,
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        topTextField.text = topSentence

        bottomTextField.attributedPlaceholder = NSAttributedString(
            string: bottomSentence,
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        bottomTextField.text = bottomSentence
    }
}
