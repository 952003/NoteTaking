//
//  ContentView.swift
//  WeatherApp
//
//  Created by 5. 3 on 03/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel(weatherService: MockWeatherService())
    @State private var showLeftSideBar = false
    @State private var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            ZStack{
                WeatherView(viewModel: viewModel)
                    .zIndex(0)
                
                if showLeftSideBar {
                    LeftSideBar(isOpen: $showLeftSideBar, viewModel: viewModel)
                        .frame(width: 300)
                        .transition(.move(edge: .leading))
                        .zIndex(1)
                        .background(Color.white)
                        .edgesIgnoringSafeArea(.vertical)
                }
                
                VStack {
                    Spacer()
                    HStack{
                        Button(action: {
                            withAnimation {
                                showLeftSideBar.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .font(.title)
                                Text("Cities")
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        Spacer()
                        
                        Button(action: {
                            if let location = locationManager.location {
                                viewModel.fetchWeather(forCoordinates: location.latitude, longitude: location.longitude)
                            } else {
                                print("Current location is not available")
                            }
                        }) {
                            HStack {
                                Image(systemName: "cloud.sun.fill")
                                    .font(.title)
                                Text("Load Weather")
                                    .fontWeight(.semibold)
                            }
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(2.0))
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 10)
                }
            }
            .navigationTitle("Weather App")
        }
    }
}

#Preview {
    ContentView()
}
