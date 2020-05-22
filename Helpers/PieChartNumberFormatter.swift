//
//  PieChartNumberFormatter.swift
//  Invest
//
//  Created by Max Mikhalskiy on 19.01.2020.
//  Copyright © 2020 Max Mikhalskiy. All rights reserved.
//

import Foundation
import Charts


public class ChartFormatter: NSObject, IValueFormatter{

    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        if(value < 2) {
            return ""
        }
        else {
            let pFormatter = NumberFormatter()
            pFormatter.numberStyle = .percent
            pFormatter.maximumFractionDigits = 1
            pFormatter.multiplier = 1
            pFormatter.percentSymbol = "%"
            let hideValue = pFormatter.string(from: NSNumber(value: value))

            return String(hideValue ?? "0")
        }
    }
}
