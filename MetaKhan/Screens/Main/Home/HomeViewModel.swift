//
//  HomeViewModel.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 22.06.23.
//

import Foundation
import UIKit
import Combine

final class HomeViewModel: BaseViewModel {
  let getAllPostsSubject = PassthroughSubject<Void, Never>()
  let setAllPostsSubject = PassthroughSubject<[PostUIModel], Never>()
  
  private var postService = PostService()
  
  override func setupBinds() {
    getAllPostsSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.getAllPosts()
      }.store(in: &cancellables)
    
    NotificationCenter.default.publisher(for: .reloadHome)
      .sink { [weak self] _ in
        guard let self = self else { return }
        self.getAllPosts()
      }.store(in: &cancellables)
  }
  
  private func getAllPosts() {
    Task {
      startLoading()
      
      let result = await postService.getAll()
      
      stopLoading()
      
      switch result {
      case .success(let response):
        let allPosts = PostUIModel.transform(with: response)
        setAllPostsSubject.send(allPosts)
      case .failure:
        print("failure")
      }
    }
  }
}
