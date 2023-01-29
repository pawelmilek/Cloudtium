//
//  PlaceData.swift
//  Lucid
//
//  Created by Pawel Milek on 25/12/2022.
//

import Foundation
import os.log

@MainActor
class PlaceData: ObservableObject {
  let logger = Logger(subsystem: "milek.pawel.Lucid.PlaceData", category: "Model")

  @Published private(set) var places: [Place]

//  private let store = Store()

  init(places: [Place] = []) {
      self.places = places
  }


}
