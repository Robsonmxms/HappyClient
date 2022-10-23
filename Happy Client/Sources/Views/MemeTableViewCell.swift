//
//  MemeTableViewCell.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 13/10/22.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    private let placeHolder = UIImage(named: "ImageError")
    private var background = UIView()
    private var topText = UILabel()
    private var bottomText = UILabel()

    var imageFromAPI = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MemeTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {
        background.addSubview(topText)
        background.addSubview(imageFromAPI)
        background.addSubview(bottomText)
        contentView.addSubview(background)
    }

    func setupConstraints() {
        setupBackgroundConstraints()
        setupTopTextConstraints()
        setupImageFromAPIConstraints()
        setupBottomTextConstraints()
    }

    func configureViews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear

        background.backgroundColor = .white
        background.layer.cornerRadius = 20
        background.translatesAutoresizingMaskIntoConstraints = false

        topText.font = .preferredFont(forTextStyle: .title1)
        topText.textColor = .black
        topText.textAlignment = .center
        topText.numberOfLines = 2
        topText.lineBreakMode = .byWordWrapping
        topText.translatesAutoresizingMaskIntoConstraints = false

        imageFromAPI.contentMode = .scaleAspectFill
        imageFromAPI.clipsToBounds = true
        imageFromAPI.translatesAutoresizingMaskIntoConstraints = false

        bottomText.font = .preferredFont(forTextStyle: .title1)
        bottomText.textColor = .black
        bottomText.textAlignment = .center
        bottomText.numberOfLines = 2
        bottomText.lineBreakMode = .byWordWrapping
        bottomText.translatesAutoresizingMaskIntoConstraints = false
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

    func setupTopTextConstraints() {
        NSLayoutConstraint.activate([
            topText.widthAnchor.constraint(
                equalTo: background.widthAnchor,
                multiplier: 0.8
            ),
            topText.topAnchor.constraint(
                equalTo: background.topAnchor,
                constant: 20
            ),
            topText.centerXAnchor.constraint(
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

    func setupBottomTextConstraints() {
        NSLayoutConstraint.activate([
            bottomText.widthAnchor.constraint(
                equalTo: background.widthAnchor,
                multiplier: 0.8
            ),
            bottomText.bottomAnchor.constraint(
                equalTo: background.bottomAnchor,
                constant: -20
            ),
            bottomText.centerXAnchor.constraint(
                equalTo: background.centerXAnchor
            )
        ])
    }

    func configure(with model: Datum) {
        let getUrl = model.image
        topText.text = model.topText
        imageFromAPI.imageFromServerURL(
            getUrl,
            placeHolder: placeHolder
        )
        bottomText.text = model.bottomText
    }
}
