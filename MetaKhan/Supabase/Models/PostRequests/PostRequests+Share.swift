//
//  PostRequests+Share.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 21.06.23.
//

import Foundation

extension PostRequests {
  struct Share: Encodable {
    var created_by: String = "0E45B741-96D0-4A03-9A18-92A858B7B75F"
    let post_text: String
  }
}
