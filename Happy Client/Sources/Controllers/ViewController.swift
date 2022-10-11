//
//  ViewController.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 11/10/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let uilabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.text = "Olá"
            return label
        }()

        view.addSubview(uilabel)

        NSLayoutConstraint.activate([
            uilabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uilabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ])

        uilabel.translatesAutoresizingMaskIntoConstraints = false

    }

}
