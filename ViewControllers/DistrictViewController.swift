//
//  DistrictViewController.swift
//  Invest
//
//  Created by Max Mikhalskiy on 06.11.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import UIKit
import Charts


class DistrictViewController: UIViewController {
    
    var districtArray: [Double] = []
    var districtIndex: Int = 0
    var chartDescription: String = "Объем инвестиций"
    let years = ["2015", "2016", "2017", "2018", "2019 \nОценка"]
    
    let districtChartView: LineChartView = {
        let districtChartView = LineChartView()
        districtChartView.clipsToBounds = true
        districtChartView.layer.cornerRadius = 15
        districtChartView.backgroundColor = UIColor(hex: "#97D8B2FF")
        districtChartView.translatesAutoresizingMaskIntoConstraints = false
        districtChartView.extraTopOffset = 35
        districtChartView.extraLeftOffset = 10
        districtChartView.extraRightOffset = 35
        districtChartView.extraBottomOffset = 10
        districtChartView.isUserInteractionEnabled = false
        districtChartView.xAxis.labelPosition = .bottom
        districtChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 13, weight: .bold)
        districtChartView.xAxis.drawGridLinesEnabled = false
        districtChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        districtChartView.leftAxis.valueFormatter = OffsetYAxisFormatter()
        districtChartView.rightAxis.drawLabelsEnabled = false
        districtChartView.legend.enabled = false
        districtChartView.animate(yAxisDuration: 1.5)
        return districtChartView
    }()
    
    let districtByVEDButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Структура инвестиций по видам экономической деятельности", for: .normal)
        btn.backgroundColor = UIColor(hex: "#8FA6CBFF")
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(pushToDistrictByVED), for: .touchUpInside)
        return btn
    }()
    
    @objc func pushToDistrictByVED(sender: UIButton!) {
        let vc = DistrictByVEDViewController()
        vc.districtIndex = districtIndex
        let nav = self.navigationController
        nav?.pushViewController(vc, animated: false)
    }
    
    let name2Button: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Реестр инвестиционных проектов", for: .normal)
        btn.backgroundColor = UIColor(hex: "#8FA6CBFF")
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
//        btn.addTarget(self, action: #selector(pushToRegion), for: .touchUpInside)
        return btn
        }()
    
    func setChart() {
        districtChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: years)
        districtChartView.xAxis.granularity = 1
        districtChartView.data = lineChartData(values: districtArray)
        districtChartView.chartDescription = setChartDescription(str: chartDescription)
    }
    
    func setChartDescription(str: String) -> Description {
        let desc = Description()
        desc.text = str
        desc.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        desc.textAlign = .center
        desc.position = CGPoint(x: view.frame.width / 2 - 25, y: 10)
        return desc
    }
    
    func lineChartData(values: [Double]) -> LineChartData{
        let data = LineChartData()
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<values.count {
            let value = ChartDataEntry(x: Double(i), y: values[i])
            lineChartEntry.append(value)
        }
        let line = LineChartDataSet(entries: lineChartEntry, label: nil)
        line.drawFilledEnabled = true
        line.valueFormatter = NumberValueFormatter()
        line.mode = .cubicBezier
        line.colors = [.white]
        line.lineWidth = 5
        line.valueFont = UIFont.systemFont(ofSize: 10, weight: .bold)
        data.addDataSet(line)
        return data
    }
    
    func setupUI() {
        view.addSubview(districtChartView)
        view.addSubview(districtByVEDButton)
        view.addSubview(name2Button)
    }
    
    func setupLayout() {
        let topSpacing = view.safeAreaLayoutGuide.topAnchor
        let avgSpacing: CGFloat = 25
        
        NSLayoutConstraint.activate([
            districtChartView.topAnchor.constraint(equalTo: topSpacing, constant: avgSpacing),
            districtChartView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: avgSpacing),
            districtChartView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -avgSpacing),
            districtChartView.bottomAnchor.constraint(equalTo: districtByVEDButton.topAnchor, constant: -avgSpacing),
            
            districtByVEDButton.topAnchor.constraint(equalTo: districtChartView.bottomAnchor, constant: avgSpacing),
            districtByVEDButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: avgSpacing),
            districtByVEDButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -avgSpacing),
            districtByVEDButton.heightAnchor.constraint(equalToConstant: 44),
            districtByVEDButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.46),
            
            name2Button.topAnchor.constraint(equalTo: districtChartView.bottomAnchor, constant: avgSpacing),
            name2Button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -avgSpacing),
            name2Button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -avgSpacing),
            name2Button.heightAnchor.constraint(equalToConstant: 44),
            name2Button.widthAnchor.constraint(equalToConstant: view.frame.width * 0.46)
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
