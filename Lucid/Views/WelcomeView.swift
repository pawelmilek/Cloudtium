//
//  WelcomeView.swift
//  Lucid
//
//  Created by Pawel Milek on 14/01/2023.
//

import SwiftUI

struct WelcomeView: View {
  private var findAttributedString: AttributedString {
    var result = AttributedString("Find")
    result.foregroundColor = ColorStyle.secondary
    result.font = .title.bold()
    return result
  }

  var body: some View {
    ZStack {
      ColorStyle.background.ignoresSafeArea()
      VStack {
        Spacer()
        Image(systemName: "cloud.sun.bolt.fill")
          .resizable()
          .scaledToFit()
          .frame(width: 280, height: 280, alignment: .center)
          .foregroundStyle(
            LinearGradient(
              colors: [ColorStyle.primary, ColorStyle.secondary],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            )
          )

        Spacer()
        VStack(spacing: 25) {
          Text(findAttributedString + " your weather predictions in your Place")
            .font(.title)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .foregroundColor(ColorStyle.text)
          Text("Easy steps to predict the weather and make your day easier")
            .font(.subheadline)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .foregroundColor(ColorStyle.textLight)

          Button {
            // TODO: - Action
          } label: {
            Text("Get Start")
              .font(.subheadline)
              .foregroundColor(ColorStyle.background)
              .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)
          }
          .background(ColorStyle.accent)
          .clipShape(Capsule())
        }
        .padding()
      }
      .padding(.bottom, 20)
    }

  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
