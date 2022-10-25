//
//  MemeService.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 13/10/22.
//

import Foundation

struct MemeServiceConstants {
    static let constUrl = "http://alpha-meme-maker.herokuapp.com"
}
struct MemeService {
    static func getMemes(
        _ requisition: String? = MemeServiceConstants.constUrl

    ) async throws -> MemeModel? {
        let getUrl = URL(
            string: requisition ?? MemeServiceConstants.constUrl
        )
        do {
            let (data, _) = try await URLSession.shared.data(from: getUrl!)
            let jsonDecode = try JSONDecoder()
                .decode(MemeModel.self, from: data)
            return jsonDecode
        } catch {
            print(error)
        }
        return nil
    }
}
