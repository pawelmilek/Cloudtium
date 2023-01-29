//
//  WeatherEndpoint.swift
//  SwiftyForecast
//
//  Created by Pawel Milek on 01/12/2022.
//

import Foundation

enum WeatherEndpoint {
  case availability(_ latitude: Double, _ longitude: Double)
  case weather(_ language: String, _ latitude: Double, _ longitude: Double)
}

// MARK: - Default implementation
extension WeatherEndpoint: Endpoint {
  var path: String {
    switch self {
    case .availability(let latitude, let longitude):
      return "/api/v1/availability/\(latitude)/\(longitude)"
      
    case .weather(let language, let latitude, let longitude):
      return "/api/v1/weather/\(language)/\(latitude)/\(longitude)"
    }
  }
  
  var method: RequestMethod {
    switch self {
    case .availability, .weather:
      return .get
    }
  }
  
  var header: [String : String]? {
    let accessToken = "eyJhbGciOiJFUzI1NiIsImtpZCI6IjJLWUdWMlBLR0YiLCJpZCI6Ik4zSEc2QzY4RVkubWlsZWsucGF3ZWwubHVjaWQud2VhdGhlcmtpdC1jbGllbnQiLCJ0eXAiOiJKV1QifQ.eyJzdWIiOiJtaWxlay5wYXdlbC5sdWNpZC53ZWF0aGVya2l0LWNsaWVudCIsImlzcyI6Ik4zSEc2QzY4RVkiLCJpYXQiOjE2NzAwODI5NzAsImV4cCI6MTY3MDA4NjU3MH0.xoJh0rDqqRqA0n6ZLTBIQgZY3-dH3OHjCbNiVCMg4t4-YC8-dm3403AP1JwrOgGe8ak5QbDz9ccWaR8Jn36Zpw"
    
    switch self {
    case .availability, .weather:
      return ["Authorization": "Bearer \(accessToken)",
              "Content-Type": "application/json;charset=utf-8"]
    }
  }
  
  var body: [String : String]? {
    switch self {
    case .availability, .weather:
      return nil
    }
  }
  
}
