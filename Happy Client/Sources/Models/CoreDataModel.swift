//
//  UserMemeModel.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 25/10/22.
//

import UIKit
import CoreData

class CoreDataModel {

    var userMemes: [NSManagedObject] = []
    var cardModel = CardModel()

    init() {}

    func fetchDataFromCoreData() {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Could not load UIApplication.shared.delegate as AppDelegate")
        }

        let manegedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserMeme")

        do {
            try self.userMemes = manegedContext.fetch(fetchRequest)

            cardModel.image.URL = self.userMemes.first?.value(
                forKey: "imageURL"
            ) as? String ?? "http://imgflip.com/s/meme/Grumpy-Cat.jpg"

            if self.userMemes.isEmpty {
                cardModel.image.isRandomImage = true
            }

        } catch let error as NSError {
            print("could not to load coreData Model \(error)")
        }
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
        userModel.setValue(self.cardModel.topSentence, forKey: "topSentence")
        userModel.setValue(self.cardModel.bottomSentence, forKey: "bottomSentence")
        userModel.setValue(self.cardModel.image.URL, forKey: "imageURL")

        do {
            if !self.userMemes.isEmpty {
                for meme in self.userMemes {
                    manegedContext.delete(meme)
                }
                self.userMemes.removeAll()
            }
            self.userMemes.append(userModel)
            try manegedContext.save()

        } catch let error as NSError {
            print("could not to save coreData Model \(error)")
        }
    }
}
