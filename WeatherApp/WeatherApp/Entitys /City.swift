//
//  City.swift
//  WeatherApp
//
//  Created by 5. 3 on 03/09/2024.
//

import Foundation

class City: Identifiable {
    let id: UUID
    var name: String
    
    init(name: String) {
        self.name = name
        self.id  = UUID()
    }
}
