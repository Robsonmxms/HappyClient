//
//  ViewController.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 11/10/22.
//

import UIKit

class ExploreViewController: UITableViewController {

    private var memeModel: MemeModel?

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

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return memeModel?.data.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        reloadVerification(indexPath.row)

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell")
                as? MemeTableViewCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        cell.configure(with: memeModel!.data[indexPath.row])
        return cell
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
