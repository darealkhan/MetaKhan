//
//  SupabaseManager.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import Supabase

final class SupabaseManager {
  
  static var currentUser: User?
  
  static let client = SupabaseClient(
    supabaseURL: URL(string: Constants.supabaseURL)!,
    supabaseKey: Constants.supabaseKEY
  )
  
  static func setCurrentUser() {
    Task {
      guard let userId = try? await client.auth.session.user.id else { return }
      currentUser = User(id: userId.uuidString)
    }
  }
}

extension SupabaseManager {
  struct User {
    let id: String
  }
}
