//
//  ApplicationStateProtocol.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/5/23.
//

import Foundation

protocol ApplicationStateProtocol {
    var state: ApplicationState { get }

    func apply(_ context: ApplicationStateManager)
}
