//
//  MemeModel.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 13/10/22.
//

import Foundation
import UIKit

// MARK: - MemeModel
struct MemeModel: Codable {
    var data: [Datum]
    var next: String?

    static func memeFactory(
        _ requisition: String? = MemeServiceConstants.constUrl
    ) async -> MemeModel? {
        do {
            let memeModel = try await MemeService.getMemes(requisition)
            return memeModel
        } catch {
            fatalError("Could not load Memes")
        }
    }

    static func loadMockJson() -> MemeModel? {
        guard let databaseInstance = Bundle.main.path(
            forResource: "Memes",
            ofType: "json"
        ) else {
            print("error loading json")
            return nil
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: databaseInstance), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(MemeModel.self, from: data)
            return jsonData
        } catch {
            print(error.localizedDescription)
        }

        return nil
    }

}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let bottomText: String?
    let image: String
    let name: String
    let topText: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case bottomText, image, name, topText
    }
}

struct ScreenSize {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}
