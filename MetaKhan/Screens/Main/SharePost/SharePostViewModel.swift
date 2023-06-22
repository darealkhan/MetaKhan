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
  var buttonDisabledSubject = PassthroughSubject<Bool, Never>()
  
  private var postText = ""
  
  private let postService = PostService()
  
  override func setupBinds() {
    shareButtonTappedSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.sharePost()
      }.store(in: &cancellables)
    
    textViewChangedSubject
      .sink { [weak self] newValue in
        guard let self = self else { return }
        self.handlePostTextChange(with: newValue)
      }.store(in: &cancellables)
  }
  
  private func sharePost() {
    Task {
      startLoading()
      
      let request = PostRequests.Share(post_text: postText)
      
      let result = await postService.sharePost(with: request)
      
      stopLoading()
      
      switch result {
      case .success:
        NavigationManager.Main.dismissPresentedView()
        NSNotification.post(name: .reloadHome)
      case .failure:
        print("failure")
      }
    }
  }
  
  private func handlePostTextChange(with newValue: String) {
    var isButtonDisabled: Bool {
      guard newValue.isEmpty else { return false }
      return true
    }
    
    self.postText = newValue
    buttonDisabledSubject.send(isButtonDisabled)
  }
}
