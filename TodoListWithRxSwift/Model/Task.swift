
//
//  Task.swift
//  TodoListWithRxSwift
//
//  Created by Krystyna Kruchkovska on 9/25/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
