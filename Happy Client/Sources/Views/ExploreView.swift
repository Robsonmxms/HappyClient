//
//  ExploreView.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 13/10/22.
//

import UIKit

class ExploreView: UIView {

    private var memeModel: MemeModel?
    private var submissionModel: SubmissionModel?

    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Olá"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        Task {
            await memeModel = MemeModel.memeFactory()
        }

        applyViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ExploreView: ViewCodeConfiguration {
    func buildHierarchy() {
        self.addSubview(label)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func configureViews() {
        self.backgroundColor = .gray
    }

}
