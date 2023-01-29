//
//  Place.swift
//  Lucid
//
//  Created by Pawel Milek on 24/12/2022.
//

struct StoreReviewConfig: Decodable {
  let locationCount: Int
  let detailsInteractionCount: Int
  let minEnjoyableTemperatureInFahrenheit: Int
  let maxEnjoyableTemperatureInFahrenheit: Int
}
