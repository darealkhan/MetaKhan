//
//  PostResponses.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 22.06.23.
//

import Foundation

struct PostResponse: Decodable {
  let id: Int
  let created_at: String
  let created_by: String
  let post_text: String
}
