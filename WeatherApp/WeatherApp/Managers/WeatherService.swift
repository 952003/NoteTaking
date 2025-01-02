//
//  WeatherService.swift
//  WeatherApp
//
//  Created by 5. 3 on 02/09/2024.
//

import Foundation
import Combine

class WeatherService: WeatherServiceProtocol {
    private let apiKey = "5ad1742834b981b441042ef2d633e6e6"
    
    
    func fetchWeather(for city: String) -> AnyPublisher<WeatherResponse, Error> {
        guard let url = createURL(for: city) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(handleResponse)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchWeather(forCoordinates latitude: Double, longitude: Double) -> AnyPublisher<WeatherResponse, Error> {
        guard let url = createURL(for: latitude, longitude: longitude) else{ return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(handleResponse)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private func createURL(for city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric")
    }
    
    private func createURL(for latitude: Double, longitude: Double) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric")
    }
    private func handleResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,              (200...299).contains(httpResponse.statusCode) else {            
            throw URLError(.badServerResponse)       
        }
        return data
    }
}
