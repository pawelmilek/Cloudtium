//
//  Bundle+ApplicationInfo.swift
//  Lucid
//
//  Created by Pawel Milek on 24/12/2022.
//

import Foundation

extension Bundle {

  var releaseVersionNumber: String? {
    let version = infoDictionary?["CFBundleShortVersionString"] as? String
    return version
  }

  var buildNumber: String? {
    let build = infoDictionary?["CFBundleVersion"] as? String
    return build
  }

  var applicationName: String? {
    return infoDictionary?["CFBundleDisplayName"] as? String
  }

  var applicationReleaseDate: String? {
    return infoDictionary?["ApplicationReleaseDate"] as? String
  }

  var applicationReleaseNumber: Int? {
    return infoDictionary?["ApplicationReleaseNumber"] as? Int
  }

  var identifierSuffix: String? {
    return infoDictionary?["BundleIdentifierSuffix"] as? String
  }

}
