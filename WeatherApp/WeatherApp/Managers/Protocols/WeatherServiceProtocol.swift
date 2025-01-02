//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by 5. 3 on 03/09/2024.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error>
    func fetchWeather(forCoordinates latitude: Double, longitude: Double) -> AnyPublisher<WeatherResponse,Error>
}
