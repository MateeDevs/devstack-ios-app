//
//  Clima.swift
//  DevStack
//
//  Created by Filip Bodnár on 11/02/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

import Foundation
import RealmSwift

@objc public class Clima: Object, Codable {
    
    // MARK: API properties
    @objc public dynamic var id: Int = 0
    @objc public dynamic var weatherStateName: String = ""
    @objc public dynamic var weatherStateAbbr: String = ""
    @objc public dynamic var created: String = ""
    @objc public dynamic var applicableDate: String = ""
    @objc public dynamic var minTemp: Float = 0.0
    @objc public dynamic var maxTemp: Float = 0.0
    @objc public dynamic var theTemp: Float = 0.0
    @objc public dynamic var windSpeed: Float = 0.0
    @objc public dynamic var windDirection: Float = 0.0
    @objc public dynamic var airPressure: Float = 0.0
    @objc public dynamic var humidity: Float = 0.0
    @objc public dynamic var visibility: Float = 0.0
    @objc public dynamic var predictability: Int = 0
    
    // MARK: Realm API
    override public static func primaryKey() -> String? {
        "id"
    }
    
    // MARK: Mapping
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case created = "created"
        case applicableDate = "applicable_date"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
        case windSpeed = "wind_speed"
        case windDirection = "wind_direction"
        case airPressure = "air_pressure"
        case humidity = "humidity"
        case visibility = "visibility"
        case predictability = "predictability"
    }
    
    // MARK: Decodable
    public convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try (container.decodeIfPresent(Int.self, forKey: .id) ?? 0)
        weatherStateName = try (container.decodeIfPresent(String.self, forKey: .weatherStateName) ?? "")
        weatherStateAbbr = try (container.decodeIfPresent(String.self, forKey: .weatherStateAbbr) ?? "")
        created = try (container.decodeIfPresent(String.self, forKey: .created) ?? "")
        applicableDate = try (container.decodeIfPresent(String.self, forKey: .applicableDate) ?? "")
        minTemp = try (container.decodeIfPresent(Float.self, forKey: .minTemp) ?? 0.0)
        maxTemp = try (container.decodeIfPresent(Float.self, forKey: .maxTemp) ?? 0.0)
        theTemp = try (container.decodeIfPresent(Float.self, forKey: .theTemp) ?? 0.0)
        windSpeed = try (container.decodeIfPresent(Float.self, forKey: .windSpeed) ?? 0.0)
        windDirection = try (container.decodeIfPresent(Float.self, forKey: .windDirection) ?? 0.0)
        airPressure = try (container.decodeIfPresent(Float.self, forKey: .airPressure) ?? 0.0)
        humidity = try (container.decodeIfPresent(Float.self, forKey: .humidity) ?? 0.0)
        visibility = try (container.decodeIfPresent(Float.self, forKey: .visibility) ?? 0.0)
        predictability = try (container.decodeIfPresent(Int.self, forKey: .predictability) ?? 0)
    }
        
    // MARK: Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(weatherStateName, forKey: .weatherStateName)
        try container.encodeIfPresent(weatherStateAbbr, forKey: .weatherStateAbbr)
        try container.encodeIfPresent(created, forKey: .created)
        try container.encodeIfPresent(applicableDate, forKey: .applicableDate)
        try container.encodeIfPresent(minTemp, forKey: .minTemp)
        try container.encodeIfPresent(maxTemp, forKey: .maxTemp)
        try container.encodeIfPresent(theTemp, forKey: .theTemp)
        try container.encodeIfPresent(windSpeed, forKey: .windSpeed)
        try container.encodeIfPresent(windDirection, forKey: .windDirection)
        try container.encodeIfPresent(airPressure, forKey: .airPressure)
        try container.encodeIfPresent(humidity, forKey: .humidity)
        try container.encodeIfPresent(visibility, forKey: .visibility)
        try container.encodeIfPresent(predictability, forKey: .predictability)
    }
    
}
