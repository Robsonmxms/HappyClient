//
//  CardModel.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 25/10/22.
//

import Foundation

struct CardModel {
    var image: Image = Image()
    var topSentence: String = ""
    var bottomSentence: String = ""
}

struct Image {
    var URL: String = "http://imgflip.com/s/meme/Grumpy-Cat.jpg"
    var isRandomImage: Bool = false
}
