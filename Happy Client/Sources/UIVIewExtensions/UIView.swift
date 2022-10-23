//
//  UIView.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 21/10/22.
//

import UIKit

extension UIView {

    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }
    }
}
