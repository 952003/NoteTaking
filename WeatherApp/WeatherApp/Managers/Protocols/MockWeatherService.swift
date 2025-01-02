//
//  MockWeatherService.swift
//  WeatherApp
//
//  Created by 5. 3 on 03/09/2024.
//

import Foundation
import Combine

class MockWeatherService: WeatherServiceProtocol {
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error> {
        let mockResponse = WeatherResponse(
            coord: Coord(lon: 21.0122, lat: 52.2297),
            weather: [
                WeatherDetail(id: 800, main: "Clear", description: "Clear sky", icon: "sun.max")
            ],
            base: "stations",
            main: WeatherMain(
                temp: 20.0,
                feelsLike: 18.0,
                tempMin: 15.0,
                tempMax: 22.0,
                pressure: 1012,
                humidity: 55,
                seaLevel: nil,
                grndLevel: nil
            ),
            visibility: 10000,
            wind: Wind(speed: 3.0, deg: 200, gust: nil),
            clouds: Clouds(all: 0),
            dt: Int(Date().timeIntervalSince1970),
            sys: System(type: 1, id: 5900, country: "PL", sunrise: 1660782056, sunset: 1660833103),
            timezone: 7200,
            id: 756135,
            name: "Warsaw",
            cod: 200,
            dailyForecast: generateMockDailyForecast()
            )
        return Just(mockResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    func fetchWeather(forCoordinates latitude: Double, longitude: Double) -> AnyPublisher<WeatherResponse, Error> {    
        return fetchWeather(for: "Warsaw")
    }
    
    private func generateMockDailyForecast() -> [DailyForecastResponse] {               return [
        DailyForecastResponse(date: Int(Date().timeIntervalSince1970) + 86400, icon: "sun.max", temperatureMin: 15.0, temperatureMax: 22.0),
        DailyForecastResponse(date: Int(Date().timeIntervalSince1970) + 86400*2, icon: "cloud.bolt.rain", temperatureMin: 14.0, temperatureMax: 19.0),
        DailyForecastResponse(date: Int(Date().timeIntervalSince1970) + 86400*3, icon: "cloud.sun", temperatureMin: 16.0, temperatureMax: 21.0),
        DailyForecastResponse(date: Int(Date().timeIntervalSince1970) + 86400*4, icon: "rain", temperatureMin: 12.0, temperatureMax: 18.0),
        DailyForecastResponse(date: Int(Date().timeIntervalSince1970) + 86400*5, icon: "sun.max", temperatureMin: 17.0, temperatureMax: 24.0)        ]    }
}
