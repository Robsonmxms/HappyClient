//
//  MemeModel.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 13/10/22.
//

import Foundation

// MARK: - MemeModel
struct MemeModel: Codable {
    let code: Int?
    let data: [Datum]
    let message: String
    let next: String

    static func memeFactory() async -> MemeModel? {
        do {
            let memeModel = try await MemeService.getMemes()
            return memeModel
        } catch {
            fatalError("Could not load Memes")
        }
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let bottomText: String?
    let image: String
    let name: String
    let rank: Int
    let tags: String
    let topText: String?

    enum CodingKeys: String, CodingKey {
        case id
        case bottomText, image, name, rank, tags, topText
    }
}
