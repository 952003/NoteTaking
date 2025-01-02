//
//  WeatherDecoder.swift
//  WeatherApp
//
//  Created by 5. 3 on 02/09/2024.
//

import Foundation

class WeatherDecoder {
    private let decoder: JSONDecoder
    
    init() {
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func decode<T: Decodable>(_ data: Data)throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}
