//
//  Place.swift
//  Lucid
//
//  Created by Pawel Milek on 24/12/2022.
//

enum AppStoreReviewStorageKey: String {
  case lastReviewVersion
  case locationCounter
  case detailsInteractionCounter
  
  var key: String {
    return self.rawValue
  }
}
