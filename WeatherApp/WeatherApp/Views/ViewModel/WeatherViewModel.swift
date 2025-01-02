//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by 5. 3 on 02/09/2024.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var weatherResponse: WeatherResponse?
    @Published var dailyForecast: [DailyForecast] = []
    @Published var errorMessage: String?
    @Published var location: CLLocationCoordinate2D?
    @Published var addedCities: [City] = []
    @Published var weatherResponses: [String: WeatherResponse] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    private let weatherService: WeatherServiceProtocol
    private let locationManager = LocationManager()
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        setupLocationSubscriber()
    }
    
    private func setupLocationSubscriber() {
        locationManager.$location
            .compactMap { $0 }
            .flatMap { [weak self] location in self?.weatherService.fetchWeather(forCoordinates: location.latitude, longitude: location.longitude) ?? Empty().eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: {[weak self] weatherResponse in 
                self?.weatherResponse = weatherResponse
                self?.processDailyForecast(weatherResponse: weatherResponse)
            })
            .store(in: &cancellables)
    }
    
    func fetchWeather(for city: String) {
        weatherService.fetchWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: {[weak self] weatherResponse in 
                self?.weatherResponses[city] = weatherResponse
                self?.processDailyForecast(weatherResponse: weatherResponse)
            })
            .store(in: &cancellables)
    }
    
    func fetchWeather(forCoordinates latitude: Double, longitude: Double) {
        weatherService.fetchWeather(forCoordinates: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: {[weak self] weatherResponse in 
                self?.weatherResponse = weatherResponse
                self?.processDailyForecast(weatherResponse: weatherResponse)
            })
            .store(in: &cancellables)
    }
    
    private func handleCompletion(_ completion: Subscribers.Completion<Error>){
        switch completion {
        case.finished:
            break
        case.failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    func addCity(name: String) {
        let newCity = City(name: name)
        addedCities.append(newCity)
        fetchWeather(for: name)
    }
    
    private func processDailyForecast(weatherResponse: WeatherResponse) {
        self.dailyForecast = weatherResponse.dailyForecast.map {
            response in DailyForecast (
                date: Date(timeIntervalSince1970: TimeInterval(response.date)),
                icon: response.icon,
                temperatureMin: response.temperatureMin,
                temperatureMax: response.temperatureMax
                )
        }
    }
}
