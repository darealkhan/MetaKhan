//
//  HomeCollectionViewManager.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 22.06.23.
//

import Foundation
import UIKit

final class HomeCollectionViewManager {
  private var posts = [PostUIModel]()
  
  init() {}
  
  func collectionView() -> UICollectionView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    collectionView.register(HomePostCell.self)
    collectionView.showsVerticalScrollIndicator = false
    collectionView.isSkeletonable = true
    return collectionView
  }
  
  func collectionViewCell(with collectionView: UICollectionView, indexPath: IndexPath) -> BaseCollectionViewCell {
    let section = Section(rawValue: indexPath.section)!
    
    switch section {
    default:
      let uiModel = posts[indexPath.row]
      let cell = collectionView.reusable(HomePostCell.self, for: indexPath)
      cell.configure(with: uiModel)
      return cell
    }
  }
  
  func collectionViewItemCount(with collectionView: UICollectionView, section: Int) -> Int {
    let section = Section(rawValue: section)
    
    switch section {
    default:
      return posts.count
    }
  }
  
  func setPosts(
    with collectionView: UICollectionView,
    posts: [PostUIModel]
  ) {
    DispatchQueue.main.async {
      self.posts = posts
      collectionView.reloadData()
    }
  }
  
  private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProdiver())
    return layout
  }
  
  private func sectionProdiver() -> UICollectionViewCompositionalLayoutSectionProvider {
    let provider: UICollectionViewCompositionalLayoutSectionProvider = { sectionIndex, environment in
      let section = Section(rawValue: sectionIndex)!
      
      switch section {
      default:
        return self.postsSection(with: section)
      }
    }
    
    return provider
  }
  
  private func postsSection(with section: Section) -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(layoutSize: section.itemLayoutSize)
    let group = NSCollectionLayoutGroup.vertical(layoutSize: section.groupLayoutSize, subitems: [item])
    let postSection = NSCollectionLayoutSection(group: group)
    postSection.interGroupSpacing = 24
    postSection.contentInsets = section.sectionContentInsets
    return postSection
  }
}

extension HomeCollectionViewManager {
  enum Section: Int {
    case posts = 0
    
    var itemLayoutSize: NSCollectionLayoutSize {
      switch self {
      case .posts:
        return NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(200)
        )
      }
    }
    
    var groupLayoutSize: NSCollectionLayoutSize {
      switch self {
      case .posts:
        return NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .estimated(200)
        )
      }
    }
    
    var sectionContentInsets: NSDirectionalEdgeInsets {
      switch self {
      case .posts:
        return NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 80, trailing: 20)
      }
    }
  }
}
