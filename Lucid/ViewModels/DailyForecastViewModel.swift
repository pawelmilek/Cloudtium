//
//  DailyForecastViewModel.swift
//  Lucid
//
//  Created by Pawel Milek on 15/01/2023.
//

import WeatherKit
import Combine
import Foundation
import SwiftUI

class DailyForecastViewModel {
  private(set) var forecast: [DayWeather]

  var gradient: LinearGradient {
    LinearGradient(colors: [ColorStyle.primary, ColorStyle.secondary],
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing)
  }

  init(forecast: Forecast<DayWeather>) {
    self.forecast = Array(forecast.forecast.prefix(10))
  }

  func safeSymbolName(_ symbolName: String) -> String {
    let name = "\(symbolName).fill"
    if let _ = UIImage(systemName: name) {
      return name
    } else {
      return symbolName
    }
  }
}
