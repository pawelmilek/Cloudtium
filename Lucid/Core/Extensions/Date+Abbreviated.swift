//
//  Date+.swift
//  Lucid
//
//  Created by Pawel Milek on 19/12/2022.
//

import Foundation

extension Date {

  var abbreviatedDay: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter.string(from: self)
  }

  var abbreviatedTime: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "ha"
    return formatter.string(from: self)
  }
  
}
