//
//  OffsetYAxisFormatter.swift
//  Invest
//
//  Created by Max Mikhalskiy on 17.10.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import Foundation
import Charts


class OffsetYAxisFormatter: IndexAxisValueFormatter {
    override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        // 2 tab
        return "\(value)        "
    }
}
