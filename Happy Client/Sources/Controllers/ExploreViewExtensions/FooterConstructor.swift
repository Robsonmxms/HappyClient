//
//  FooterControllerComponents.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 23/10/22.
//

import UIKit
import CoreData

extension ExploreViewController {

    func buildFooterSectionView() -> FooterSectionView {
        let footerView = FooterSectionView()
        footerView.diceButton.addTarget(
            self,
            action: #selector(self.diceButtonTapped),
            for: .touchUpInside
        )
        footerView.doneButton.addTarget(
            self,
            action: #selector(self.doneButtonTapped),
            for: .touchUpInside
        )
        return footerView
    }

    @objc func diceButtonTapped(sender: UIButton) {
        let randomElement = memeModel?.data.randomElement()
        self.coreDataModel.cardModel.image.URL = randomElement!.image
        self.coreDataModel.cardModel.image.isRandomImage = true
        tableView.reloadData()
    }

    @objc func doneButtonTapped(sender: UIButton) {
        let alert = UIAlertController(
            title: "Save Changes",
            message: "Do you want to save the changes made to your meme?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: "Save",
            style: .default,
            handler: {_ in self.saveChanges()}
        ))
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))

        self.present(alert, animated: true, completion: nil)

    }

    func saveChanges() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath)

        setTopSentence(cell)
        setBottomSentence(cell)
        coreDataModel.saveDataInCoreData()
    }

    func setTopSentence(_ cell: UITableViewCell?) {
        let userMemeCell = cell as? UserMemeTableViewCell
        self.coreDataModel.cardModel
            .topSentence = userMemeCell?.topTextField.text ?? ""
    }

    func setBottomSentence(_ cell: UITableViewCell?) {
        let userMemeCell = cell as? UserMemeTableViewCell
        self.coreDataModel.cardModel
            .bottomSentence = userMemeCell?.bottomTextField.text ?? ""
    }

}
