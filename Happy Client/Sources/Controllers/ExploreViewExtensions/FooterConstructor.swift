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
        self.imageURL = randomElement!.image
        self.isRandomImage = true
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
        saveDataInCoreData()
    }

    func setTopSentence(_ cell: UITableViewCell?) {
        let topTextField = cell?.contentView.subviews[0].subviews[0] as? TextFieldView
        self.topSentence = topTextField?.text ?? ""
    }

    func setBottomSentence(_ cell: UITableViewCell?) {
        let bottomTextField = cell?.contentView.subviews[0].subviews[2] as? TextFieldView
        self.bottomSentence = bottomTextField?.text ?? ""
    }

    func saveDataInCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let manegedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(
            forEntityName: "UserMeme",
            in: manegedContext
        )!
        let userModel = NSManagedObject(
            entity: entity,
            insertInto: manegedContext
        )
        userModel.setValue(self.topSentence, forKey: "topSentence")
        userModel.setValue(self.bottomSentence, forKey: "bottomSentence")
        userModel.setValue(self.imageURL, forKey: "imageURL")

        do {
            if !self.userMeme.isEmpty {
                for meme in self.userMeme {
                    manegedContext.delete(meme)
                }
                print(self.userMeme.count)
                self.userMeme.removeAll()
            }
            self.userMeme.append(userModel)
            try manegedContext.save()

        } catch let error as NSError {
            print("could not to save coreData Model \(error)")
        }
    }
}
