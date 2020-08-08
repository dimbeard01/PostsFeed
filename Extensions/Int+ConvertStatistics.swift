//
//  Int+ConvertStatistics.swift
//  PostsFeed
//
//  Created by Dima on 08.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import Foundation

extension Int {
    func convertStatistics() -> String {
        if self > 1000 {
            return "\(self/1000)K"
        } else if self > 1000000 {
            return "\(self/1000000)M"
        } else {
            return "\(self)"
        }
    }
}
