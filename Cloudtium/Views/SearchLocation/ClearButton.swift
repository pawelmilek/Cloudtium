//
//  ClearButton.swift
//  Cloudtium
//
//  Created by Pawel Milek on 5/6/23.
//

import SwiftUI

struct ClearButton: View {
    @Binding var text: String

    var body: some View {
        if text.isEmpty == false {
            HStack {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                }
                .foregroundColor(.secondary)
            }
        } else {
            EmptyView()
        }
    }
}

struct ClearButton_Previews: PreviewProvider {
    static var previews: some View {
      ClearButton(text: .constant("Some Text"))
        .padding()
        .previewLayout(.sizeThatFits)

    }
}
