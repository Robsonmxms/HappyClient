//
//  SubmissionModel.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 13/10/22.
//

import Foundation

// MARK: - SubmissionModel
struct SubmissionModel: Codable {
    let data: [SubDatum]

    static func submissionFactory(
        _ memeID: Int
    ) async -> SubmissionModel? {
        do {
            let submissionModel = try await MemeService.getMemeSubmission(memeID)
            return submissionModel
        } catch {
            fatalError("Could not load Meme Submissions")
        }
    }
}

// MARK: - Datum
struct SubDatum: Codable {
    let bottomText, topText: String
}
