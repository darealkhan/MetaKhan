//
//  PostService.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 21.06.23.
//

import Foundation
import Supabase

protocol PostServiceType {
  func sharePost(with request: PostRequests.Share) async -> PostService.SharePostPartialState
}

final class PostService: PostServiceType {
  private let table = SupabaseTableName.posts.rawValue
  
  func sharePost(with request: PostRequests.Share) async -> SharePostPartialState {
    do {
      print(request)
      print(SupabaseManager.currentUser?.id ?? "")
      let result = try await SupabaseManager.client.database
        .from(table)
        .insert(values: request)
        .execute()
      
      print("success")
      return .success
    } catch {
      print(error.localizedDescription)
      return .failure
    }
  }
}

extension PostService {
  enum SharePostPartialState {
    case success
    case failure
  }
}
