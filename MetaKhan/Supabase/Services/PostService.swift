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
  func getAll() async -> PostService.GetAllPartialState
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
  
  func getAll() async -> GetAllPartialState {
    do {
      let result = try await manager.client.database
        .from(table)
        .select()
        .order(column: "created_at", ascending: false)
        .execute()
      
      let data = result.underlyingResponse.data
      
      let decodedData = try JSONDecoder().decode([PostResponse].self, from: data)
      
      return .success(decodedData)
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
  
  enum GetAllPartialState {
    case success([PostResponse])
    case failure
  }
}
