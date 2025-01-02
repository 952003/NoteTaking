//
//  CityListView.swift
//  WeatherApp
//
//  Created by 5. 3 on 03/09/2024.
//

import SwiftUI

struct CityListView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Binding var isOpen: Bool
    
    var body: some View {
            List {
                ForEach(viewModel.addedCities) { city in
                    if let weather = viewModel.weatherResponses[city.name] {
                        CityWeatherView(city: city, weather: weather)
                    } else {
                        Text("\(city.name): Weather data not available")
                            .foregroundColor(.gray)
                    }
                }
            }
            .listStyle(PlainListStyle())
    }
}


