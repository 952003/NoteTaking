//
//  LeftSideBar.swift
//  WeatherApp
//
//  Created by 5. 3 on 03/09/2024.
//

import SwiftUI

struct LeftSideBar: View {
    @Binding var isOpen: Bool
    @ObservedObject var viewModel: WeatherViewModel
    
    @State private var newCityName: String = ""
    @State private var showingAddCityAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter city name", text: $newCityName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Add") {
                        if !newCityName.isEmpty {
                            viewModel.addCity(name: newCityName)
                            newCityName = ""
                        }
                    }
                    .padding(.trailing)
                }
                CityListView(viewModel: viewModel, isOpen: $isOpen)
                    .frame(maxWidth: .infinity)
            }
            .navigationTitle("Weather App")
            .padding()
        }
    }
}

