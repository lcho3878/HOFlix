//
//  UITextField+Extension.swift
//  HOFlix
//
//  Created by 이찬호 on 6/5/24.
//

import UIKit

extension UITextField  {
    func underlined(_ w: Int , _ color: UIColor) {
        let border = CALayer()
        let width = CGFloat(w)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
}
