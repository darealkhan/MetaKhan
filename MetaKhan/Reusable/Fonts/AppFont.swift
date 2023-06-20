//
//  AppFont.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import UIKit

struct AppFont {
  
  static func poppins(ofSize size: CGFloat, weight: PoppinsFontWeight) -> UIFont {
    
    let name = "Poppins-\(weight.rawValue)"
    return UIFont(name: name, size: size) ?? UIFont()
  }
}

enum PoppinsFontWeight: String {
  
  // MARK: Main Fonts
  
  case bold = "Bold"
  case semiBold = "SemiBold"
  case medium = "Medium"
  case regular = "Regular"
  case light = "Light"
  
  // MARK: Additional Fonts
  
  case black = "Black"
  case blackItalic = "BlackItalic"
  case boldItalic = "BoldItalic"
  case extraBold = "ExtraBold"
  case extraBoldItalic = "ExtraBoldItalic"
  case extraLight = "ExtraLight"
  case extraLightItalic = "ExtraLightItalic"
  case italic = "Italic"
  case lightItalic = "LightItalic"
  case mediumItalic = "MediumItalic"
  case semiBoldItalic = "SemiBoldItalic"
  case thin = "Thin"
  case thinItalic = "ThinItalic"
}
