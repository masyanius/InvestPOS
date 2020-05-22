//
//  NumberValueFormatter.swift
//  Invest
//
//  Created by Max Mikhalskiy on 14.10.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import Foundation
import Charts


class NumberValueFormatter: NSObject, IValueFormatter {
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        let valueWithTwoDig = String(format: "%.1f", value)
        return "\(valueWithTwoDig)"
    }
}
