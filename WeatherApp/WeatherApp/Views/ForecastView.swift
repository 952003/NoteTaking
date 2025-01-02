//
//  ForecastView.swift
//  WeatherApp
//
//  Created by 5. 3 on 03/09/2024.
//

import SwiftUI

struct ForecastView: View {
    let dailyForecast: [DailyForecast]
    
    var body: some View {
        VStack {
            Text("Daily Forecast")
                .font(.headline)
                .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(dailyForecast, id: \.date) { forecast in
                        VStack {
                            Text(forecast.date, style: .date)
                                .font(.headline)
                            Image(systemName: forecast.icon)
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("\(forecast.temperatureMin, specifier: "%.1f")°C/\(forecast.temperatureMax,specifier: "%.1f")°C")
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    ForecastView(dailyForecast: [
        DailyForecast(date: Date(), icon: "sun.max", temperatureMin: 15, temperatureMax: 25),
        DailyForecast(date: Date().addingTimeInterval(86400), icon: "cloud.sun", temperatureMin: 16, temperatureMax: 26),
        DailyForecast(date: Date().addingTimeInterval(172800), icon: "cloud.rain", temperatureMin: 14, temperatureMax: 24)    ])}

