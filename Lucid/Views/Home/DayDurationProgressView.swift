//
//  DayDurationGaugeView.swift
//  Lucid
//
//  Created by Pawel Milek on 09/01/2023.
//

import SwiftUI
import WeatherKit

struct DayDurationProgressView: View {
  var sunrise: Date
  var sunset: Date

  private var minimumValueInHours: Double {
    0.0
  }

  private var minimumValueInHoursFormatted: String {
    0.formatted(.number)
  }

  private var leftHoursMinutesInDayFormatted: String {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .abbreviated
    formatter.allowedUnits = [.hour, .minute]
    formatter.zeroFormattingBehavior = [.pad]

    let minutes = Measurement(value: leftMinutesInDay, unit: UnitDuration.minutes)
    let leftSecondsInDay = minutes.converted(to: .seconds)
    let result = formatter.string(from: leftSecondsInDay.value)
    return result ?? ""
  }

  private var leftMinutesInDay: Double {
    let minutesFromSunriseToNow = Double(calculateMinutesFromSunriseToNow())
    return max(maximumValueInMinutes - minutesFromSunriseToNow, 0)
  }

  private var minutesFromSunriseToNow: Double {
    var result = Double(calculateMinutesFromSunriseToNow())

    if result > maximumValueInMinutes {
      return maximumValueInMinutes
    } else {
      return result
    }
  }

  private var maximumValueInMinutes: Double {
    let result = calculateTotalMinutesFromSunriseToSunset()
    return Double(result)
  }

  var body: some View {
    VStack(spacing: 15) {
      //      Text("Now: \(Date.now.formatted())")
      HStack {
        HStack {
          Image(systemName: "sunrise.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20, alignment: .center)
            .foregroundStyle(LinearGradient(colors: [ColorStyle.secondary, ColorStyle.primary],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing))
            .shadow(color: ColorStyle.secondary, radius: 2, x: 0, y: 0)
          Text(sunrise.formatted(date: .omitted, time: .shortened))
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundColor(ColorStyle.text)
        }

        Spacer()

        HStack {
          Text(sunset.formatted(date: .omitted, time: .shortened))
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundColor(ColorStyle.text)

          Image(systemName: "sunset.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 22, height: 22, alignment: .center)
            .foregroundStyle(LinearGradient(colors: [ColorStyle.primary, ColorStyle.secondary],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing))
            .shadow(color: ColorStyle.primary, radius: 2, x: 0, y: 0)
        }
      }

//      Text("ProgressView value: \(minutesFromSunriseToNow)")
//      Text("ProgressView total: \(maximumValueInMinutes)")
      ProgressView(value: minutesFromSunriseToNow, total: maximumValueInMinutes) {
        Text("Day time left " + leftHoursMinutesInDayFormatted)
          .font(.footnote)
          .fontWeight(.medium)
          .lineLimit(1)
          .frame(height: 24)
          .padding(.horizontal, 20)
          .background(ColorStyle.capsule)
          .foregroundColor(ColorStyle.text)
          .clipShape(Capsule())
      }
      .progressViewStyle(WithBackgroundProgressViewStyle())

    }
    .padding(.top, 20)
    .background(ColorStyle.background)
  }

  private func calculateTotalMinutesFromSunriseToSunset() -> UInt {
    let dateComponents = Calendar.current.dateComponents([.minute], from: sunrise, to: sunset)
    return UInt(dateComponents.minute ?? 0)
  }

  private func calculateMinutesFromSunriseToNow() -> UInt {
    let dateComponents = Calendar.current.dateComponents([.minute], from: sunrise, to: Date.now)
    return UInt(max(dateComponents.minute ?? 0, 0))
  }
}

struct DayDurationProgressView_Previews: PreviewProvider {
  static let sunState = WeatherModel.sanFranciscoDailyForecast!.forecast
    .first(where: { $0.date.formatted(date: .abbreviated, time: .omitted) == Date.now.formatted(date: .abbreviated, time: .omitted) })!.sun

  static var previews: some View {
    DayDurationProgressView(sunrise: sunState.sunrise!, sunset: sunState.sunset!)
      .previewLayout(.sizeThatFits)
  }
}

struct WithBackgroundProgressViewStyle: ProgressViewStyle {

  func makeBody(configuration: Configuration) -> some View {
    ProgressView(configuration)
      .padding(.vertical, 5)
      .background(ColorStyle.background)
      .tint(ColorStyle.secondary)
  }
  
}
