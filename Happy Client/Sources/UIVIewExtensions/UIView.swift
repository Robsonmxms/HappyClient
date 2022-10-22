//
//  UIView.swift
//  Happy Client
//
//  Created by Robson Lima Lopes on 21/10/22.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
