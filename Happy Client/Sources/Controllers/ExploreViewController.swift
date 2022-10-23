//
//  ViewController.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 11/10/22.
//

import UIKit
import CoreData

class ExploreViewController: UITableViewController {

    var memeModel: MemeModel?

    var userMeme: [NSManagedObject] = []

    var imageURL: String = "http://imgflip.com/s/meme/Grumpy-Cat.jpg"
    var topSentence: String = ""
    var bottomSentence: String = ""

    var isRandomImage: Bool = false

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

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let isSharingImage = section == 0
        let header = HeaderSectionView(frame: .zero, isSharingImage: isSharingImage)

        header.shareButton.addTarget(
            self,
            action: #selector(self.shareImage),
            for: .touchUpInside
        )
        return header
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return self.buildFooterSectionView()
        } else {
            return UIView()
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
}
