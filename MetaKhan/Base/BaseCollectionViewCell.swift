//
//  BaseCollectionViewCell.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit

protocol BaseCollectionViewCellProtocol {
  static var reuseIdentifier: String { get }
}

class BaseCollectionViewCell: UICollectionViewCell, BaseCollectionViewCellProtocol {
  static var reuseIdentifier: String {
    return String(describing: Self.self)
  }
}
