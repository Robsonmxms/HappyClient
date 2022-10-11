//
//  ViewCodeConfiguration.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 11/10/22.
//

import Foundation

protocol ViewCodeConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeConfiguration {
    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
