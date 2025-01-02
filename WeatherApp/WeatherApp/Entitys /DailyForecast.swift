//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by 5. 3 on 03/09/2024.
//

import Foundation

struct DailyForecast: Identifiable {
    let id = UUID()
    let date: Date
    let icon: String
    let temperatureMin: Double
    let temperatureMax: Double
}
