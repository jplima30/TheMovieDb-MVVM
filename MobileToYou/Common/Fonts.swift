//
//  Fonts.swift
//  MobileToYou
//
//  Created by jplima on 28/11/22.
//

import Foundation
import UIKit

enum Fonts {

    case small(UIFont.Weight)
    case medium(UIFont.Weight)
    case large(UIFont.Weight)
    case PrincipalMovieLargeTitle(UIFont.Weight)

    var font: UIFont {
        switch self {
        case .small(let weight):
            return UIFont.systemFont(ofSize: 12, weight: weight)
        case .medium(let weight):
            return UIFont.systemFont(ofSize: 18, weight: weight)
        case .large(let weight):
            return UIFont.systemFont(ofSize: 25, weight: weight)
        case .PrincipalMovieLargeTitle(let weight):
            return UIFont.systemFont(ofSize: 30, weight: weight)
        }
    }
}
