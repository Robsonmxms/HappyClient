//
//  ViewController.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 11/10/22.
//

import UIKit

class ExploreViewController: UITableViewController {

    private var memeModel: MemeModel?
    private var imageURL: String = "http://imgflip.com/s/meme/Grumpy-Cat.jpg"
    private var topSentence: String = ""
    private var bottomSentence: String = ""

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
                action: #selector(self.diceButtonTapped)
                , for: .touchUpInside
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

    @objc func diceButtonTapped(sender: UIButton) {
        let randomElement = memeModel?.data.randomElement()
        self.imageURL = randomElement!.image
        tableView.reloadData()
    }

    @objc func doneButtonTapped(sender: UIButton) {
        let indexPath = NSIndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        let topTextField = cell?.contentView.subviews[0].subviews[0] as? TextFieldView

        let bottomTextField = cell?.contentView.subviews[0].subviews[2] as? TextFieldView

        topSentence = topTextField?.text ?? ""
        bottomSentence = bottomTextField?.text ?? ""

        print(topSentence)
        print(bottomSentence)
        print(imageURL)
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
            //            cell.configure(imageURL: "http://imgflip.com/s/meme/Grumpy-Cat.jpg")
            cell.configure(imageURL: imageURL)
            return cell

        case .list:
            //            reloadVerification(indexPath.row)

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell")
                    as? MemeTableViewCell else {
                fatalError("DequeueReusableCell failed while casting")
            }
            cell.configure(with: memeModel!.data[indexPath.row])
            return cell
        }
    }

    func reloadVerification(_ index: Int) {
        let isTheLastRowIndex = index+1 == memeModel?.data.count
        let isTheLastRequisition = memeModel?.next != "http://alpha-meme-maker.herokuapp.com/12"
        if  isTheLastRowIndex && isTheLastRequisition {
            buildNextMemes()
        }
    }

    func buildNextMemes() {
        var newMemeModel: MemeModel?
        Task {
            await newMemeModel = MemeModel.memeFactory(memeModel?.next)

            memeModel?.data.append(contentsOf: newMemeModel?.data ?? [])
            memeModel?.next = newMemeModel?.next ?? ""
            tableView.reloadData()
        }
    }
}
