//
//  CheckmarkView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 8/10/23.
//

import SwiftUI

struct CheckmarkView: View {
    let title: String
    let index: Int
    @Binding var checkmarkIndex: Int

    var body: some View {
        Button(action: {
            checkmarkIndex = index
        }) {
            HStack {
                Text(title)
                    .foregroundColor(ColorStyle.text)
                    .frameAlignment(.leading)
                if index == checkmarkIndex {
                    Image(systemName: "checkmark")
                        .foregroundColor(ColorStyle.text)
                }
            }
        }
    }
}

struct CheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkView(title: "Title", index: 0, checkmarkIndex: .constant(0))
            .previewLayout(.sizeThatFits)
    }
}
