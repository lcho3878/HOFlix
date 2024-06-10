//
//  UITableViewCell+Extension.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import UIKit

protocol ReusableProtocol {
    static var id: String { get }
}

extension UITableViewCell: ReusableProtocol {
    static var id: String {
        return String(describing: self)
    }
    
    
}
