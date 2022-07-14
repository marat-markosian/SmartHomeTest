//
//  DataManager.swift
//  SmartHome
//
//  Created by Марат Маркосян on 14.07.2022.
//

import Foundation

protocol DataManagerDelegate {
    func didUpdateData(_ dataManager: DataManager, data: [DeviceModel])
    func didFailWithError(error: Error)
}

struct DataManager {
    
    var delegate: DataManagerDelegate?
    
    func fetchData() {
        let urlString = "http://storage42.com/modulotest/data.json"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                return
            }
            
            if let safeData = data {
                if let devices = parseJSON(safeData) {
                    delegate?.didUpdateData(self, data: devices)
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(_ deviceData: Data) -> [DeviceModel]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(DeviceData.self, from: deviceData)
            var devices = [DeviceModel]()
            
            for index in 0 ..< decodedData.devices.count {
                let deviceName = decodedData.devices[index].deviceName
                let type = decodedData.devices[index].productType
                if type == "Light" {
                    let mode = decodedData.devices[index].mode
                    let intens = decodedData.devices[index].intensity
                    
                    let device = DeviceModel(name: deviceName, type: type, mode: mode, intensity: intens, position: nil)
                    devices.append(device)
                }
                if type == "RollerShutter" {
                    let position = decodedData.devices[index].position
                    
                    let device = DeviceModel(name: deviceName, type: type, mode: nil, intensity: nil, position: position)
                    devices.append(device)
                }
            }
            
            return devices
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
