//
//  UIImage+Extensions.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit

extension UIImage {
  func resizeImage() -> UIImage {
    let image = self
    let targetSize = CGSize(width: 40, height: 40)
    
    // Compute the scaling ratio for the width and height separately
    let widthScaleRatio = targetSize.width / image.size.width
    let heightScaleRatio = targetSize.height / image.size.height
    
    // To keep the aspect ratio, scale by the smaller scaling ratio
    let scaleFactor = min(widthScaleRatio, heightScaleRatio)
    
    // Multiply the original image’s dimensions by the scale factor
    // to determine the scaled image size that preserves aspect ratio
    let scaledImageSize = CGSize(
      width: image.size.width * scaleFactor,
      height: image.size.height * scaleFactor
    )
    
    let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
    let scaledImage = renderer.image { _ in
      image.draw(in: CGRect(origin: .zero, size: scaledImageSize))
    }
    
    return scaledImage
  }
  
  func withInset(_ insets: UIEdgeInsets) -> UIImage? {
    let cgSize = CGSize(
      width: self.size.width + insets.left * self.scale + insets.right * self.scale,
      height: self.size.height + insets.top * self.scale + insets.bottom * self.scale
    )
    
    UIGraphicsBeginImageContextWithOptions(cgSize, false, self.scale)
    defer { UIGraphicsEndImageContext() }
    
    let origin = CGPoint(x: insets.left * self.scale, y: insets.top * self.scale)
    self.draw(at: origin)
    
    return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(self.renderingMode)
  }
}
