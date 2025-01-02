





import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(spacing: 20) {
            if let errorMessage = viewModel.errorMessage{
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
                    .multilineTextAlignment(.center)
            } else if let response = viewModel.weatherResponse {
                VStack(spacing: 10) {
                    Text(response.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\(response.main.temp, specifier: "%.1f")°C")
                        .font(.system(size: 100))
                        .fontWeight(.thin)
                        .foregroundColor(.white)
                    
                    Text(response.weather.first?.description.capitalized ?? "No description")
                        .font(.title2)
                        .foregroundColor(.white)
                        .italic()
                    
                    HStack {
                        Text("Humidity: \(response.main.humidity)%")
                            .foregroundColor(.white)
                        Spacer()
                        Text("Wind Speed: \(response.wind.speed) m/s")
                            .foregroundColor(.white)
                    }
                    .font(.subheadline)
                    
                    if let iconName = response.weather.first?.icon {
                        Image(systemName: iconName)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(20)
                .shadow(radius: 10)
                
                ForecastView(dailyForecast: viewModel.dailyForecast)
                
            } else {
                ProgressView("Loading Weather Data..")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.fetchWeather(for: "Warsaw")
        }
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel(weatherService: MockWeatherService()))
}
