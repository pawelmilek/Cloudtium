//
//  SelectionListDataSource.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/10/23.
//

import Foundation

protocol SelectionListDataSource {
    associatedtype Item: ListItemDisplayable

    var items: [Item] { get }
    var numberOfItems: Int { get }
    func item(at index: Int) -> Item?
}

struct SelectionListDataSourceGenerator {
    static func listProviderTemperature() -> any SelectionListDataSource {
        let items = [TemperatureItem(index: 0, name: "Fahrenheit", unit: .fahrenheit),
                     TemperatureItem(index: 1, name: "Celsius", unit: .celsius)]
        return TemperatureListDataSource(items: items)
    }

    static func listProviderSpeed() -> any SelectionListDataSource {
        let items = [SpeedItem(index: 0, name: "Miles per hour", unit: .milesPerHour),
                     SpeedItem(index: 1, name: "Kilometers per hour", unit: .kilometersPerHour)]
       return  SpeedListDataSource(items: items)
    }
}
