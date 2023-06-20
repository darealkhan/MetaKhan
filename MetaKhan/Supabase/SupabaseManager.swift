//
//  SupabaseManager.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import Supabase

final class SupabaseManager {
  let client = SupabaseClient(supabaseURL: URL(string: Constants.supabaseURL)!, supabaseKey: Constants.supabaseKEY)
}
