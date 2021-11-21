//
//  WeatherData.swift
//  Clima
//
//  Created by Alex Osipova on 26.07.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
//    let coord: Coord
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
 
//struct Coord: Codable {
//    let lat: Double
//    let lon: Double
//}

