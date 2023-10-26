//
//  Weather.swift
//  weatherAPP
//
//  Created by Миржигит Суранбаев on 23/10/23.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}


// MARK: - Main
struct Main: Codable {
    let temp: Double
}


// MARK: - Weather
struct Weather: Codable {
    let icon: String
}
