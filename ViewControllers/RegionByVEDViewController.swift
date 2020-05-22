//
//  TypesViewController.swift
//  Invest
//
//  Created by Max Mikhalskiy on 05.11.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import UIKit
import Charts


class RegionByVEDViewController: UIViewController {
    let colors: [String] = ["#EAF9D9FF", "#824C71FF", "#E58F65FF", "#797A9EFF", "#96BE5CFF", "#DD6031FF", "#C3C9E9FF", "#C1B8C8FF"]
    var colorsAfterPercents: [String] = []
    
    private let regionVEDChartView: BarChartView = {
        let regionVEDChartView = BarChartView()
        regionVEDChartView.clipsToBounds = true
        regionVEDChartView.layer.cornerRadius = 15
        regionVEDChartView.backgroundColor = UIColor(hex: "#97D8B2FF")
        regionVEDChartView.translatesAutoresizingMaskIntoConstraints = false
        regionVEDChartView.extraLeftOffset = 10
        regionVEDChartView.extraBottomOffset = 10
        regionVEDChartView.isUserInteractionEnabled = false
        regionVEDChartView.xAxis.labelPosition = .bottom
        regionVEDChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 13, weight: .bold)
        regionVEDChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        regionVEDChartView.drawValueAboveBarEnabled = false
        regionVEDChartView.leftAxis.spaceBottom = 0
        regionVEDChartView.leftAxis.drawGridLinesEnabled = false
        regionVEDChartView.rightAxis.drawGridLinesEnabled = false
        regionVEDChartView.xAxis.drawGridLinesEnabled = false
        regionVEDChartView.rightAxis.drawLabelsEnabled = false
        regionVEDChartView.leftAxis.valueFormatter = PercentYAxisFormatter()
        regionVEDChartView.legend.enabled = false
        regionVEDChartView.animate(yAxisDuration: 1.5)
        return regionVEDChartView
    }()
    
    func convertNumbersToPercentOf(numbers: [Double]) -> [Double] {
        var array: [Double] = []
        for i in 0..<numbers.count {
            let value = numbers[i] / numbers.sum() * 100
            array.append(value)
//            if value > 2 {
//                array.append(value)
//                colorsAfterPercents.append(colors[i])
//            }
        }
        return array
       }
       
    func hexArrayToUIColor(hexArray: [String]) -> [UIColor] {
        var colorArray: [UIColor] = []
        for i in 0..<hexArray.count {
        colorArray.append(UIColor(hex: hexArray[i])!)
        }
        return colorArray
       }
    
    func barChartData() -> BarChartData{
        var barDataEntries: [BarChartDataEntry] = []
        for i in 0..<MainViewController.investJSON().barCharts.regionVED.count {
            barDataEntries.append(BarChartDataEntry(x: Double(i), yValues: convertNumbersToPercentOf(numbers: MainViewController.investJSON().barCharts.regionVED[i].value)))
           }
        let barDataSet = BarChartDataSet(entries: barDataEntries, label: nil)
        barDataSet.colors = hexArrayToUIColor(hexArray: colors)
        barDataSet.drawValuesEnabled = true
        barDataSet.valueFont = UIFont.systemFont(ofSize: 10, weight: .bold)
        let data = BarChartData(dataSets: [barDataSet])
        return data
        }
    
    func yearsArray() -> [String]{
        var array: [String] = []
        for i in 0..<MainViewController.investJSON().barCharts.regionVED.count {
            array.append(MainViewController.investJSON().barCharts.regionVED[i].year)
        }
        return array
    }

    func setChart() {
        regionVEDChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: yearsArray())
        regionVEDChartView.extraRightOffset = view.frame.width * 0.05
        regionVEDChartView.data = barChartData()
        regionVEDChartView.chartDescription = setChartDescription(str: "Структура инвестиций в основной капитал\n по видам экономической деятельности", multiplier: 1)
    }
    
    func setChartDescription(str: String, multiplier: CGFloat) -> Description {
        let desc = Description()
        desc.text = str
        desc.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        desc.textAlign = .center
        desc.position = CGPoint(x: view.frame.width * 0.27, y: 10)
        return desc
    }
    
    func setupUI() {
        view.addSubview(regionVEDChartView)
    }
    
    func setupLayout() {
        let topSpacing = view.safeAreaLayoutGuide.topAnchor
        let avgSpacing: CGFloat = 25
        let step: CGFloat = 10
        
        NSLayoutConstraint.activate([
            regionVEDChartView.topAnchor.constraint(equalTo: topSpacing, constant: avgSpacing),
            regionVEDChartView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: avgSpacing),
            regionVEDChartView.rightAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 2 + 100 - step),
            regionVEDChartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -avgSpacing)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupLayout()
        setChart()
    }

}
