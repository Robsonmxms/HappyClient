//
//  ViewController.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 11/10/22.
//

import UIKit
import CoreData

class ExploreViewController: UITableViewController {

    private var memeModel: MemeModel?

    private var userMeme: [NSManagedObject] = []

    private var imageURL: String = "http://imgflip.com/s/meme/Grumpy-Cat.jpg"
    private var topSentence: String = ""
    private var bottomSentence: String = ""

    private var isRandomImage: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            memeModel = MemeModel.loadMockJson()
            self.tableView.reloadData()
        }
        self.tableView = ExploreView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let manegedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserMeme")

        do {
            try self.userMeme = manegedContext.fetch(fetchRequest)

            self.imageURL = self.userMeme.first?.value(
                forKey: "imageURL"
            ) as? String ?? "http://imgflip.com/s/meme/Grumpy-Cat.jpg"

            if self.userMeme.isEmpty {
                self.isRandomImage = true
            }

        } catch let error as NSError {
            print("could not to load coreData Model \(error)")
        }
    }
}

extension ExploreViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return CellType.allCases.count
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if CellType.allCases[section] == .list {
            return memeModel?.data.count ?? 0
        }
        return 1

    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
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
        } else {
            return UIView()
        }
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .largeTitle)

        if section == 0 {
            label.text = "Your Meme"
            return label

        } else {
            label.text = "Community Memes"
            return label
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = CellType.allCases[indexPath.section]

        switch currentItem {

        case .edit:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "userMemeCell")
                    as? UserMemeTableViewCell else {
                fatalError("DequeueReusableCell failed while casting")
            }
            cell.configure(
                userMeme: userMeme.first,
                imageURL: self.imageURL,
                isRandomImage: self.isRandomImage
            )
            self.isRandomImage = false
            return cell

        case .list:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell")
                    as? MemeTableViewCell else {
                fatalError("DequeueReusableCell failed while casting")
            }
            cell.configure(with: memeModel!.data[indexPath.row])
            return cell
        }
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
            title: "Continue",
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
        saveInCoreData()
    }

    func setTopSentence(_ cell: UITableViewCell?) {
        let topTextField = cell?.contentView.subviews[0].subviews[0] as? TextFieldView
        self.topSentence = topTextField?.text ?? ""
    }

    func setBottomSentence(_ cell: UITableViewCell?) {
        let bottomTextField = cell?.contentView.subviews[0].subviews[2] as? TextFieldView
        self.bottomSentence = bottomTextField?.text ?? ""
    }

    func saveInCoreData() {
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
                for interable in 0...self.userMeme.count-1 {
                    manegedContext.delete(self.userMeme[interable])
                }
                self.userMeme.removeAll()
            }
            self.userMeme.append(userModel)
            try manegedContext.save()

        } catch let error as NSError {
            print("could not to save coreData Model \(error)")
        }
    }
}
