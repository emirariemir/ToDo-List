//
//  TodoItem.swift
//  ToDo-List
//
//  Created by Emir Arı on 20.05.2024.
//

import Foundation
import SwiftData

@Model
class TodoItem {
    let title: String
    let subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
