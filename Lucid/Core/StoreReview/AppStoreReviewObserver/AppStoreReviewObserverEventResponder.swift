//
//  Place.swift
//  Lucid
//
//  Created by Pawel Milek on 24/12/2022.
//


protocol AppStoreReviewObserverEventResponder: AnyObject {
  func appStoreReviewDesirableMomentDidHappen(_ desirableMoment: ReviewDesirableMomentType)
}
