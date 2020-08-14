//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Clark Lindsay on 8/13/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate resource '\(file)' in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to read data from '\(url)'")
        }
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard let result = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        return result
    }
}
