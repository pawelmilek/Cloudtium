//
//  CurrentConditionView.swift
//  Lucid
//
//  Created by Pawel Milek on 11/01/2023.
//

import SwiftUI

struct CurrentConditionDetailsView: View {
  var humidity: Double
  var pressure: Measurement<UnitPressure>
  var windSpeed: Measurement<UnitSpeed>
  
  var body: some View {
    HStack(alignment: .center) {
      HStack(alignment: .center, spacing: 10) {
        Image(systemName: "humidity")
          .foregroundColor(ColorStyle.condition)
        Text("\(Int(humidity * 100).formatted(.percent))")
      }
      Spacer()
      HStack(alignment: .center, spacing: 10) {
        Image(systemName: "rectangle.compress.vertical")
          .foregroundColor(ColorStyle.condition)
        Text(pressure.formatted())
      }
      Spacer()
      HStack(alignment: .center, spacing: 10) {
        Image(systemName: "wind")
          .foregroundColor(ColorStyle.condition)
        Text(windSpeed.formatted())
      }
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .font(.footnote)
    .fontWeight(.medium)
    .foregroundColor(ColorStyle.text)
    .padding(.vertical, 10)
  }
}

struct CurrentConditionDetailsView_Previews: PreviewProvider {
  private static let palce = Place.sanFrancisco
  private static let current = WeatherModel.sanFranciscoCurrentWeather!
  
  static var previews: some View {
    CurrentConditionDetailsView(humidity: current.humidity,
                                pressure: current.pressure,
                                windSpeed: current.wind.speed)
    .previewLayout(.sizeThatFits)
  }
}
