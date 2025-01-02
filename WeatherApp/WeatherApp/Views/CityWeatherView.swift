//
//  CityWeatherView.swift
//  WeatherApp
//
//  Created by 5. 3 on 03/09/2024.
//

import SwiftUI

struct CityWeatherView: View {
    var city: City
    var weather: WeatherResponse?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(city.name)
                .font(.title)
                .bold()
            
            if let weather = weather {
                HStack {
                    Text(weather.weather.first?.description.capitalized ?? "N/A")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text("\(weather.main.temp, specifier: "%.1f") °C")
                        .font(.largeTitle)
                        .bold()
                }
                .padding(.bottom)
                
                HStack {
                    Text("Min: \(weather.main.tempMin, specifier: "%.1f") °C")
                        .font(.footnote)
                    Spacer()
                    Text("Max: \(weather.main.tempMax, specifier: "%.1f") °C")
                        .font(.footnote)
                }
                .foregroundColor(.gray)
                
                Text("Time: \(formattedTime(from: weather.dt))")
                    .font(.footnote)
                    .foregroundColor(.gray)
            } else {
                Text("Weather data not available")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    private func formattedTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
        
    }
}

struct CityWeatherView_Previews: PreviewProvider {    static var previews: some View {        
    let testCity = City(name: "Moscow")
    let testWeather = WeatherResponse(            
        coord: Coord(lon: 37.6173, lat: 55.7558),
        weather: [WeatherDetail(id: 801, main: "Clouds", description: "few clouds", icon: "02d")],
        base: "stations",
        main: WeatherMain(temp: 15.0, feelsLike: 15.0, tempMin: 10.0, tempMax: 20.0, pressure: 1012, humidity: 75, seaLevel: nil, grndLevel: nil),
        visibility: 10000,
        wind: Wind(speed: 3.6, deg: 240, gust: nil),
        clouds: Clouds(all: 20),
        dt: Int(Date().timeIntervalSince1970),
        sys: System(type: 1, id: 9028, country: "RU", sunrise: 1633021200, sunset: 1633079641),
        timezone: 10800,
        id: 524901,
        name: "Moscow",
        cod: 200,
        dailyForecast: []
    )
    CityWeatherView(city: testCity, weather: testWeather)              .previewLayout(.sizeThatFits)
        .padding()    }}
