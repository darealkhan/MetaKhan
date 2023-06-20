//
//  AppScrollView.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit
import SnapKit

final class AppScrollView: UIScrollView {
  
  var contentView = UIView()
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
  }
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    
    finishSetup()
  }
  
  required init?(coder: NSCoder) {
    
    fatalError("init(coder:) has not been implemented")
  }
  
  func finishSetup() {
    
    addSubview(contentView)
    
    contentView.snp.makeConstraints { make in
      make.top.equalTo(self.snp.top)
      make.width.equalTo(self.snp.width)
      make.bottom.equalTo(self.snp.bottom)
    }
    
    layoutIfNeeded()
  }
}
