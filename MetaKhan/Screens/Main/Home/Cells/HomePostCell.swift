//
//  HomePostCell.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 22.06.23.
//

import Foundation
import UIKit

final class HomePostCell: BaseCollectionViewCell {
  
  private var postText: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    layer.cornerRadius = 10
  }
  
  private func setupViews() {
    backgroundColor = .secondarySystemBackground
    
    postText = UILabel.new {
      $0.font = AppFont.poppins(ofSize: 14, weight: .regular)
      $0.textColor = .label
      $0.numberOfLines = 0
      $0.isSkeletonable = true
    }
    
    contentView.addSubview(postText)
    
    postText.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(20)
      make.bottom.trailing.equalToSuperview().offset(-20)
    }
  }
  
  func configure(with uiModel: PostUIModel) {
    postText.text = uiModel.post_text
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
