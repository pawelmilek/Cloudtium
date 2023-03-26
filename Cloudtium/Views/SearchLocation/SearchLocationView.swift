//
//  SearchLocationView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 5/6/23.
//

import SwiftUI
import MapKit

struct SearchLocationView: View {
  @StateObject var viewModel: SearchLocationViewModel
  @FocusState private var isFocusedTextField: Bool

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Form {
          Section(header: Text("Location Search")) {
            HStack {
              TextField("Search", text: $viewModel.queryFragment)
                .autocorrectionDisabled()
                .focused($isFocusedTextField)
//                .font(.callout)
//                .background(.red)

              if viewModel.status == .isSearching {
                Image(systemName: "clock")
                  .foregroundColor(Color.gray)
              }

              ClearButton(text: $viewModel.queryFragment)
            }
          }
          .onAppear {
            isFocusedTextField = true
          }

          Section(header: Text("Results")) {
            List {
              switch viewModel.status {
              case .noResults:
                Text("No Resutls")

              case .error(let description):
                Text("Error: \(description)")

              default:
                EmptyView()
              }

              ForEach(viewModel.results) { result in
                // This simply lists the results, use a button in case you'd like to perform an action
                // or use a NavigationLink to move to the next view upon selection.
                AddressRowView(address: result)
              }
            }
          }
        }
      }
    }
  }
}

struct SearchLocationView_Previews: PreviewProvider {
  static var previews: some View {
    SearchLocationView(viewModel: SearchLocationViewModel())
  }
}
