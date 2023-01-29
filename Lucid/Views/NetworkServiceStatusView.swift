//
//  NetworkServiceStatusView.swift
//  Lucid
//
//  Created by Pawel Milek on 14/01/2023.
//

import SwiftUI

struct NetworkServiceStatusView: View {
    var body: some View {
      ZStack {
        ColorStyle.background.ignoresSafeArea()
        Text("NetworkServiceStatusView")
      }
    }
}

struct NetworkServiceStatusView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkServiceStatusView()
    }
}
