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
      $0.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
      $0.font = AppFont.poppins(ofSize: 14, weight: .regular)
      $0.textColor = .label
      $0.numberOfLines = 0
    }
    
    addSubview(postText)
    
    postText.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(20)
      make.bottom.trailing.equalToSuperview().offset(-20)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
