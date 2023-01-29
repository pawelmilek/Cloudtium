//
//  UserDefaultsWrapped.swift
//  Lucid
//
//  Created by Pawel Milek on 25/12/2022.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapped<Value> {
  let key: UserDefaultsWrappedKey
  let defaultValue: Value
  var container: UserDefaults = .standard

  var wrappedValue: Value {
    get {
      return container.object(forKey: key.value) as? Value ?? defaultValue
    }
    set {
      container.set(newValue, forKey: key.value)
    }
  }

}
