//
//  FavoriteView.swift
//  Lucid
//
//  Created by Pawel Milek on 08/01/2023.
//

import SwiftUI

struct FavoriteView: View {
    var body: some View {
      ZStack {
        ColorStyle.background.ignoresSafeArea()
        Text("Favorite Places")
      }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
