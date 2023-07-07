//
//  Colors.swift
//  MobileToYou
//
//  Created by jplima on 28/11/22.
//

import Foundation
import UIKit

enum Colors: String {

    case secondary
    case primary
    case background
    case overlay

    var color: UIColor? {
        return UIColor(named: self.rawValue)
    }
}
