//
//  MemeService.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 13/10/22.
//

import Foundation

struct MemeServiceConstants {
    static let constUrl = "http://alpha-meme-maker.herokuapp.com"
    static let memeUrl = "http://alpha-meme-maker.herokuapp.com/memes/"
}
struct MemeService {
    static func getMemes() async throws -> MemeModel? {
        let getUrl = URL(
            string: MemeServiceConstants.constUrl
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

    static func postMemeSubmission(_ submission: SubmissionModel) async throws -> SubmissionModel? {
        let submissionURL = MemeServiceConstants.memeUrl + String(submission.memeId)

        var request = URLRequest(url: URL(string: submissionURL)!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        do {
            let jsonData = try JSONEncoder().encode(submission)
            request.httpBody = jsonData
            let (data, _) = try await URLSession.shared.data(for: request)
            let userData = try JSONDecoder().decode(SubmissionModel.self, from: data)
            return userData
        } catch {
            print(error)
        }
        return nil
    }
}
