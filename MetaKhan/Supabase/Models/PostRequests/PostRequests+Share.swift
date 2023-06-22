//
//  PostRequests+Share.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 21.06.23.
//

import Foundation

extension PostRequests {
  struct Share: RequestWithUserId, Encodable {
    var created_by: String = ""
    let post_text: String
    
    mutating func setUserId(with newValue: String?) {
      self.created_by = newValue ?? ""
    }
  }
}
