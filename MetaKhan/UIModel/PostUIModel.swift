//
//  PostUIModel.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 22.06.23.
//

import Foundation

struct PostUIModel {
  let id: Int
  let created_at: String
  let created_by: String
  let post_text: String
  
  static func transform(with response: [PostResponse]) -> [PostUIModel] {
    return response.compactMap {
      return PostUIModel(
        id: $0.id,
        created_at: $0.created_at,
        created_by: $0.created_by,
        post_text: $0.post_text
      )
    }
  }
}

extension PostUIModel {
  static func mock() -> PostUIModel {
    return PostUIModel(
      id: 0,
      created_at: "",
      created_by: "",
      post_text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
    )
  }
}
