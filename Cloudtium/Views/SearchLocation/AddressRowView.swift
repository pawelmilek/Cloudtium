//
//  AddressRowView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 5/6/23.
//

import SwiftUI

struct AddressRowView: View {
    let address: SearchLocationResultModel

    var body: some View {
        NavigationLink {
            Text("Handle Navigation hierarchy")
        } label: {
            VStack(alignment: .leading) {
                Text(address.title)
                Text(address.subtitle)
                    .font(.caption)
            }
        }
        .padding(.bottom, 2)
    }
}

struct AddressRowView_Previews: PreviewProvider {
    static var previews: some View {
      AddressRowView(address: SearchLocationResultModel(title: "Title",
                                                        subtitle: "Subtitle"))
    }
}
