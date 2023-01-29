//
//  LocationRequestView.swift
//  Lucid
//
//  Created by Pawel Milek on 28/12/2022.
//

import SwiftUI

struct LocationRequestView: View {
  @EnvironmentObject var locationManager: LocationManager

  private var shareAttributedString: AttributedString {
    var result = AttributedString("share")
    result.foregroundColor = ColorStyle.secondary
    result.font = .title.bold()
    return result
  }

  var body: some View {
    ZStack {
      ColorStyle.background.ignoresSafeArea()
      VStack {
        Spacer()
        Image(systemName: "location.circle.fill")
          .resizable()
          .scaledToFit()
          .frame(width: 200, height: 200, alignment: .center)
          .foregroundStyle(
            LinearGradient(
              colors: [ColorStyle.primary, ColorStyle.secondary],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )
        Spacer()

        VStack(alignment: .center, spacing: 25) {
          Text("Would you like to " + shareAttributedString + " your location?")
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .foregroundColor(ColorStyle.text)
          Text("Start sharing your location with us")
            .font(.subheadline)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .frame(width: 200)
            .foregroundColor(ColorStyle.textLight)
        }
        VStack(alignment: .center) {
          Button {
            locationManager.requestLocation()
          } label: {
            Text("Share location")
              .font(.subheadline)
              .foregroundColor(ColorStyle.background)
              .frame(minWidth: 0, maxWidth: .infinity)
          }
          .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
          .background(ColorStyle.accent)
          .clipShape(Capsule())

          Button {
            openSettings()

          } label: {
            Text("Open settings")
              .font(.subheadline)
              .foregroundColor(ColorStyle.accent)
              .frame(minWidth: 0, maxWidth: .infinity)
          }
          .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
          .clipShape(Capsule())
        }
        .padding()
      }
    }
  }

  private func openSettings() {
    if let url = NSURL(string: UIApplication.openSettingsURLString) as URL? {
      UIApplication.shared.open(url, options: [:])
    }
  }
}

struct LocationRequestView_Previews: PreviewProvider {
  static var previews: some View {
    LocationRequestView().environmentObject(LocationManager())
  }
}
