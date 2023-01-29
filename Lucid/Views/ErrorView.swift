//
//  ErrorView.swift
//  Lucid
//
//  Created by Pawel Milek on 02/01/2023.
//

import SwiftUI

struct ErrorView: View {
    var errorText: String

    var body: some View {
        VStack {
            Image(systemName: "xmark.octagon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 100, alignment: .center)
            Text(errorText)
        }
        .padding()
        .foregroundColor(.white)
        .background(.red)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorText: "Error Message")
    }
}
