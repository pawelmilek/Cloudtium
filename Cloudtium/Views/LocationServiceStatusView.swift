//
//  LocationServiceStatusView.swift
//  Cloudtium
//
//  Created by Pawel Milek on 14/01/2023.
//

import SwiftUI

struct LocationServiceStatusView: View {
  var body: some View {
    ZStack {
      ColorStyle.background
      VStack {
        HStack(alignment: .center, spacing: 10) {
          Image(systemName: "location.slash.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25, alignment: .center)

          Text("Location Services Disabled")
            .font(.title3)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
        }
        .foregroundColor(ColorStyle.text)

        VStack(alignment: .center, spacing: 10) {
          Text("Location is required to provide accurate forecast for your current location.")
            .font(.subheadline)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .foregroundColor(ColorStyle.text)
            .padding(.bottom, 20)

          Group {
            Button {
              openSettings()
            } label: {
              Text("Open settings")
                .font(.subheadline)
                .foregroundColor(ColorStyle.background)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 45)
            }
            Button {
              openAddNewPlace()
            } label: {
              Text("Add location")
                .font(.subheadline)
                .foregroundColor(ColorStyle.background)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 45)
            }

          }
          .background(ColorStyle.accent)
          .clipShape(Capsule())
          .padding(.horizontal, 60)
        }
        .padding(.horizontal, 15)
      }
    }
  }

  private func openAddNewPlace() {
    if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
      UIApplication.shared.open(url, options: [:])
    }
  }

  private func openSettings() {
    if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
      UIApplication.shared.open(url, options: [:])
    }
  }
}

struct LocationServiceStatusView_Previews: PreviewProvider {
  static var previews: some View {
    LocationServiceStatusView()
      .previewLayout(.sizeThatFits)
  }
}
