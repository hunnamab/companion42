//
//  Constants.swift
//  swifty-companion
//
//  Created by Anastasia on 14.08.2021.
//

import Foundation
import UIKit

enum CustomFont: String {
    case regular = "Ubuntu-Regular"
    case light = "Ubuntu-Light"
    case medium = "Ubuntu-Medium"
    case bold = "Ubuntu-Bold"
    case italic = "Ubuntu-Italic"
    
    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
