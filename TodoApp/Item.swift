//
//  Item.swift
//  TodoApp
//
//  Created by Waseem Abbas on 17/07/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
