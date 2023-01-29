//
//  DataDecoder.swift
//  Lucid
//
//  Created by Pawel Milek on 25/12/2022.
//

import Foundation

struct DataDecoder<M> where M: Decodable {

  static func decode(_ data: Data) -> Result<M, Error> {
    do {
      let model = try JSONDecoder().decode(M.self, from: data)
      return .success(model)
    } catch {
      return .failure(error)
    }
  }

}
