//
//  FavoriteView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 08/01/2023.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: FavoriteViewModel
    @State private var queryString = ""

    var body: some View {
        ZStack {
            BackgroundView(color: ColorStyle.favoriteBackground)
            List {
                ForEach(viewModel.locations, id: \.self) { _ in
                    FavoriteCard()
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .onDelete { indexSet in
                    viewModel.delete(at: indexSet)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .onAppear {
            viewModel.load()
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView(viewModel: FavoriteViewModel())
    }
}
