//
//  UIImage.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 13/10/22.
//

import UIKit

extension UIImageView {
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        self.image = placeHolder
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let setUrl = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: setUrl, completionHandler: { (data, _ , error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
