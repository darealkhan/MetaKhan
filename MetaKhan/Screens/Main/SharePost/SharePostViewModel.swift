//
//  SharePostViewModel.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 21.06.23.
//

import Foundation
import Combine
import UIKit

final class SharePostViewModel: BaseViewModel {
  var shareButtonTappedSubject = PassthroughSubject<Void, Never>()
  var textViewChangedSubject = PassthroughSubject<String, Never>()
  
  private var postText = ""
  
  private let postService = PostService()
  
  override func setupBinds() {
    
    shareButtonTappedSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.sharePost()
      }.store(in: &cancellables)
    
    textViewChangedSubject
      .sink { [weak self] postText in
        guard let self = self else { return }
        self.postText = postText
      }.store(in: &cancellables)
  }
  
  private func sharePost() {
    Task {
      startLoading()
      
      let request = PostRequests.Share(post_text: postText)
      
      let result = await postService.sharePost(with: request)
      
      switch result {
      case .success:
        print("succces")
      case .failure:
        print("failure")
      }
    }
  }
}
