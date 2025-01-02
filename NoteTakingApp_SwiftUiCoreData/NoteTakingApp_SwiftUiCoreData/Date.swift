//
//  Date.swift
//  NoteTakingApp_SwiftUiCoreData
//
//  Created by 5. 3 on 30/07/2024.
//

import Foundation

extension Date {
    func asString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
