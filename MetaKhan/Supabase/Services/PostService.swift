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
  private let manager = SupabaseManager()
  private let table = SupabaseTableName.posts.rawValue
  
  func sharePost(with request: PostRequests.Share) async -> SharePostPartialState {
    do {
      await manager.setCurrentUser()
      
      var finalRequest = request
      finalRequest.setUserId(with: manager.currentUser?.id)
      
      _ = try await manager.client.database
        .from(table)
        .insert(values: finalRequest)
        .execute()
      
      return .success
    } catch {
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
