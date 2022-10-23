//
//  HeaderConstructor.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 23/10/22.
//

import UIKit

extension ExploreViewController {
    @objc func shareImage(sender: UIButton) {
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = tableView.cellForRow(at: indexPath) as? UserMemeTableViewCell else {
            fatalError("Could not load TableViewCell as UserMemeTableView")
        }

        let image: UIImage = cell.asImage()

        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(
            activityItems: imageToShare,
            applicationActivities: nil
        )
        activityViewController.popoverPresentationController?
            .sourceView = self.view

        self.present(activityViewController, animated: true, completion: nil)
    }
}
