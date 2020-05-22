//
//  PercentYAxisFormatter.swift
//  Invest
//
//  Created by Max Mikhalskiy on 21.10.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import Foundation
import Charts


class PercentYAxisFormatter: IndexAxisValueFormatter {
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let string = String(format: "%.0f", value)
        return "\(string)%"
    }
}
