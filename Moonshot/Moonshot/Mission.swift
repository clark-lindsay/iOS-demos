//
//  Mission.swift
//  Moonshot
//
//  Created by Clark Lindsay on 8/13/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewMember: Codable {
        var name: String
        var role: String
    }
    
    var id: Int
    var crew: [CrewMember]
    var launchDate: Date?
    var description: String
    var displayName: String {
        "Apollo \(self.id)"
    }
    
    var image: String {
        "apollo\(self.id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            return dateFormatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
