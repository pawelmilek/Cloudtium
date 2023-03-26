//
//  SelectionListView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/10/23.
//

import SwiftUI

struct SelectionListView: View {
    let title: String
    let dataSource: any SelectionListDataSource
    @Binding var checkmarkIndex: Int

    var body: some View {
        ZStack {
            BackgroundView(color: ColorStyle.favoriteBackground)
            List {
                ForEach(dataSource.items, id: \.index) { item in
                    CheckmarkView(
                        title: item.name,
                        index: item.index,
                        checkmarkIndex: $checkmarkIndex
                    )
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SelectionListView_Previews: PreviewProvider {
    static let tempListDataSource = SelectionListDataSourceGenerator.listProviderTemperature()
    static let speedListDataSource = SelectionListDataSourceGenerator.listProviderSpeed()

    static var previews: some View {
        NavigationStack {
            SelectionListView(
                title: "Temperature",
                dataSource: tempListDataSource,
                checkmarkIndex: .constant(0)
            )
        }
        .previewDisplayName("Temperature List")

        NavigationStack {
            SelectionListView(
                title: "Speed",
                dataSource: speedListDataSource,
                checkmarkIndex: .constant(1)
            )
        }
        .previewDisplayName("Speed List")
        .environmentObject(SettingsStorage.shared)
    }
}
