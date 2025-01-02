//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by 5. 3 on 02/09/2024.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Coord
    let weather: [WeatherDetail]
    let base: String
    let main: WeatherMain
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: System
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    let dailyForecast: [DailyForecastResponse]
}

struct DailyForecastResponse: Codable {
    let date: Int
    let icon: String
    let temperatureMin: Double
    let temperatureMax: Double
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct WeatherDetail: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherMain: Codable {
    let temp: Double
    let feelsLike: Double
    // Use CodingKeys for mapping
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let seaLevel: Double?
    let grndLevel: Double?
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct Clouds: Codable {
    let all: Int
}

struct System: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

