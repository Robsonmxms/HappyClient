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

extension UIImage {
    func resizeImage(_ targetSize: CGSize) -> UIImage {
        let size = self.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
