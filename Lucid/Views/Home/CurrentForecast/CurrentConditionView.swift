//
//  CurrentPlaceConditionView.swift
//  Lucid
//
//  Created by Pawel Milek on 11/01/2023.
//

import SwiftUI

struct CurrentConditionView: View {
  var placeName: String
  var symbolName: String
  var temperature: Measurement<UnitTemperature>
  var shortConditionDescription: String

  private var safeSymbolName: String {
    let name = "\(symbolName).fill"
    if let _ = UIImage(systemName: name) {
      return name
    } else {
      return symbolName
    }
  }

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 10) {
        Text(placeName)
          .font(.title3)
          .padding(.top, 25)

        Text(temperature.formatted(Style.narrowTemperatureStyle))
          .font(.system(size: 78))
          .scaledToFill()
          .minimumScaleFactor(0.5)
          .lineLimit(1)

        Text(shortConditionDescription)
          .font(.subheadline)
          .fontWeight(.medium)
          .lineLimit(1)
          .frame(height: 33)
          .padding(.horizontal, 20)
          .background(ColorStyle.capsule)
          .clipShape(Capsule())
      }
      .padding(.top, 35)
      Spacer()

      Image(systemName: safeSymbolName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 180, height: 250, alignment: .center)
        .foregroundStyle(
          LinearGradient(
            colors: [ColorStyle.primary, ColorStyle.secondary],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
          )
        )
        .shadow(color: ColorStyle.primary, radius: 35, x: 0, y: 10)
    }
    .foregroundColor(ColorStyle.text)
  }
}

struct CurrentConditionView_Previews: PreviewProvider {
  private static let palce = Place.sanFrancisco
  private static let current = WeatherModel.sanFranciscoCurrentWeather!

  static var previews: some View {
    CurrentConditionView(placeName: palce.city,
                         symbolName: current.symbolName,
                         temperature: current.temperature,
                         shortConditionDescription: current.condition.description)
    .previewLayout(.sizeThatFits)
  }
}
