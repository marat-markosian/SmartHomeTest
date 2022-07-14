//
//  DeviceData.swift
//  SmartHome
//
//  Created by Марат Маркосян on 14.07.2022.
//

import Foundation

struct DeviceData: Decodable {
    
    let devices: [Device]
    
}

struct Device: Decodable {
    
    let deviceName: String
    let productType: String
    let position: Int?
    let mode: String?
    let intensity: Int?
    
}
