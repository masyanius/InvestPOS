//
//  RegionViewController.swift
//  Invest
//
//  Created by Max Mikhalskiy on 19.10.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import UIKit
import Charts


class RegionViewController: UIViewController {
    let years = ["2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019 \nОценка"]
    
    private let regionChartView: LineChartView = {
        let regionChartView = LineChartView()
        regionChartView.clipsToBounds = true
        regionChartView.layer.cornerRadius = 15
        regionChartView.backgroundColor = UIColor(hex: "#97D8B2FF")
        regionChartView.translatesAutoresizingMaskIntoConstraints = false
        regionChartView.extraTopOffset = 35
        regionChartView.extraLeftOffset = 10
        regionChartView.extraRightOffset = 35
        regionChartView.extraBottomOffset = 10
        regionChartView.isUserInteractionEnabled = false
        regionChartView.xAxis.labelPosition = .bottom
        regionChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 13, weight: .bold)
        regionChartView.xAxis.drawGridLinesEnabled = false
        regionChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        regionChartView.leftAxis.valueFormatter = OffsetYAxisFormatter()
        regionChartView.rightAxis.drawLabelsEnabled = false
        regionChartView.legend.enabled = false
        regionChartView.animate(yAxisDuration: 1.5)
        return regionChartView
    }()
    
    private let internationalRegionChartView: LineChartView = {
        let internationalRegionChartView = LineChartView()
        internationalRegionChartView.clipsToBounds = true
        internationalRegionChartView.layer.cornerRadius = 15
        internationalRegionChartView.backgroundColor = UIColor(hex: "#97D8B2FF")
        internationalRegionChartView.translatesAutoresizingMaskIntoConstraints = false
        internationalRegionChartView.extraRightOffset = 35
        internationalRegionChartView.extraLeftOffset = 10
        internationalRegionChartView.extraBottomOffset = 10
        internationalRegionChartView.extraTopOffset = 40
        internationalRegionChartView.isUserInteractionEnabled = false
        internationalRegionChartView.xAxis.labelPosition = .bottom
        internationalRegionChartView.xAxis.labelFont = UIFont.systemFont(ofSize: 13, weight: .bold)
        internationalRegionChartView.xAxis.drawGridLinesEnabled = false
        internationalRegionChartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        internationalRegionChartView.leftAxis.valueFormatter = OffsetYAxisFormatter()
        internationalRegionChartView.rightAxis.drawLabelsEnabled = false
        internationalRegionChartView.legend.enabled = false
        internationalRegionChartView.animate(yAxisDuration: 1.5)
        return internationalRegionChartView
    }()
    
    let typesButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 1
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Структура инвестиций по видам экономической деятельности", for: .normal)
        btn.titleLabel?.lineBreakMode = .byWordWrapping
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = UIColor(hex: "#8FA6CBFF")
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(pushToNextVC), for: .touchUpInside)
        return btn
    }()

    let countryButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = 2
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Структура инвестиций по странам", for: .normal)
        btn.titleLabel?.lineBreakMode = .byWordWrapping
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = UIColor(hex: "#8FA6CBFF")
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(pushToNextVC), for: .touchUpInside)
        return btn
    }()
    
    @objc func pushToNextVC(sender: UIButton!) {
        var vc = UIViewController()
        switch sender.tag {
        case 1:
            vc = RegionByVEDViewController()
        case 2:
            vc = StructureByCountryViewController()
        default:
            break
        }
        let nav = self.navigationController
        DispatchQueue.main.async {
            nav?.view.layer.add(CATransition().segueFromBottom(), forKey: nil)
            nav?.pushViewController(vc, animated: false)
        }
    }
    
    func setChart() {
        regionChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: years)
        regionChartView.data = lineChartData(values: MainViewController.investJSON().lineCharts.region[0])
        regionChartView.chartDescription = setChartDescription(str: "Объем инвестиций в Ленинградскую область", multiplier: 1)
        
        internationalRegionChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: years)
        internationalRegionChartView.data = lineChartData(values: MainViewController.investJSON().lineCharts.region[1])
        internationalRegionChartView.chartDescription = setChartDescription(str: "Объем иностранных инвестиций в Ленинградскую область", multiplier: 1)
    }
    
    func setChartDescription(str: String, multiplier: CGFloat) -> Description {
        let desc = Description()
        desc.text = str
        desc.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        desc.textAlign = .center
        desc.position = CGPoint(x: view.frame.width / 2 * multiplier, y: 10)
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
        view.addSubview(regionChartView)
        view.addSubview(internationalRegionChartView)
        view.addSubview(typesButton)
        view.addSubview(countryButton)
    }
    
    func setupLayout() {
        let topSpacing = view.safeAreaLayoutGuide.topAnchor
        let avgSpacing: CGFloat = 25
        
        NSLayoutConstraint.activate([
        regionChartView.topAnchor.constraint(equalTo: topSpacing, constant: avgSpacing),
        regionChartView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: avgSpacing),
        regionChartView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -avgSpacing),
        regionChartView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.32),
        
        internationalRegionChartView.topAnchor.constraint(equalTo: typesButton.bottomAnchor, constant: 5),
        internationalRegionChartView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: avgSpacing),
        internationalRegionChartView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -avgSpacing),
        internationalRegionChartView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.32),
        
        typesButton.heightAnchor.constraint(equalToConstant: 44),
        typesButton.topAnchor.constraint(equalTo: regionChartView.bottomAnchor, constant: 5),
        typesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        typesButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5),
        
        countryButton.heightAnchor.constraint(equalToConstant: 44),
        countryButton.topAnchor.constraint(equalTo: internationalRegionChartView.bottomAnchor, constant: 5),
        countryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        countryButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5)
        ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Объем инвестиций в Ленинградскую область"
        setupUI()
        setupLayout()
        setChart()
    }

}

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element {
        return reduce(.zero, +)
    }
}
