//
//  UICollectionView+Extensions.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit

extension UICollectionView {
  
  func register<C: BaseCollectionViewCell>(_ cell: C.Type) {
    
    self.register(C.self, forCellWithReuseIdentifier: cell.reuseIdentifier)
  }
  
  func reusable<C: BaseCollectionViewCell>(
    _ cell: C.Type,
    for indexPath: IndexPath
  ) -> C {
    
    let cell = self.dequeueReusableCell(
      withReuseIdentifier: cell.reuseIdentifier,
      for: indexPath
    ) as! C
    return cell
  }
}
