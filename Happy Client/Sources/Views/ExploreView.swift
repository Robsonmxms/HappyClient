//
//  ExploreView.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 13/10/22.
//

import UIKit

class ExploreView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .insetGrouped)
        applyViewCode()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExploreView: ViewCodeConfiguration {
    func buildHierarchy() {}

    func setupConstraints() {}

    func configureViews() {
        self.backgroundColor = .brown
        self.separatorStyle = .none
        self.register(MemeTableViewCell.self, forCellReuseIdentifier: "memeCell")
        self.register(UserMemeTableViewCell.self, forCellReuseIdentifier: "userMemeCell")
    }

}
