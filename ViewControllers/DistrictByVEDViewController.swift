//
//  DistrictByVEDViewController.swift
//  Invest
//
//  Created by Max Mikhalskiy on 21.11.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import UIKit
import Charts


class DistrictByVEDViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var districtIndex: Int = 0
    var lessThan2TypeStrings: [String] = []
    var newTypeStrings: [String] = []
    let typeStrings = ["Сельское, лесное хозяйство, охота, рыболовство и рыбоводство",
    "Добыча полезных ископаемых",
    "Обрабатывающие производства",
    "Обеспечение электрическое энергией, газом и паром; кондиционирование воздуха",
    "Водоснабжение; водоотведение, организация сбора и утилизации отходов, деятельность по ликвидации загрязнений",
    "Строительство",
    "Торговля оптовая и розничная; ремонт автотранспортных средств и мотоциклов",
    "Транспортировка и хранение",
    "Деятельность гостинец и предприятий общественного питания",
    "Деятельность в области информации и связи",
    "Деятельность финансовая и страховая",
    "Деятельность по операциям с недвижимым имуществом",
    "Деятельность профессиональная, научная и техническая",
    "Деятельность административная и сопутствующие дополнительные услуги",
    "Государственное управление и обеспечение военной безопасности; социальное обеспечение",
    "Образование",
    "Деятельность в области здравоохранения и социальных услуг",
    "Деятельность в области культуры, спорта, организации досуга и развлечений",
    "Предоставление прочих видов услуг"]
    var newColors: [String] = []
    let colors: [String] = ["#99CFC0FF", "#AE9896FF", "#C0B3C2FF", "#E5B5B9FF", "#B2E8FFFF", "#DD8B54FF", "#B6A1E7FF", "#459DABFF", "#E3929CFF", "#818892FF", "#D1E499FF", "#FBBCA3FF", "#A3BCDAFF", "#FFE35CFF", "#E3CCD2FF", "#CEA087FF", "#DAD1FFFF", "#D487C1FF", "#FFE35CFF"]
    
    let pieView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let districtChartView2016: PieChartView = {
        let pcv = PieChartView()
        pcv.translatesAutoresizingMaskIntoConstraints = false
        pcv.legend.enabled = false
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        pcv.centerAttributedText = NSAttributedString(string: "2016", attributes: attributes)
        pcv.holeRadiusPercent = 0.3
        pcv.transparentCircleRadiusPercent = 0.45
        pcv.setExtraOffsets(left: 20, top: 20, right: 20, bottom: 20)
        pcv.animate(yAxisDuration: 2)
        
        
        return pcv
    }()
    
    let districtChartView2017: PieChartView = {
        let pcv = PieChartView()
        pcv.translatesAutoresizingMaskIntoConstraints = false
        pcv.legend.enabled = false
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        pcv.centerAttributedText = NSAttributedString(string: "2017", attributes: attributes)
        pcv.holeRadiusPercent = 0.3
        pcv.transparentCircleRadiusPercent = 0.45
        pcv.setExtraOffsets(left: 20, top: 20, right: 20, bottom: 20)
        pcv.animate(yAxisDuration: 2)
        
        return pcv
    }()
    
    let districtChartView2018: PieChartView = {
        let pcv = PieChartView()
        pcv.translatesAutoresizingMaskIntoConstraints = false
        pcv.legend.enabled = false
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        pcv.centerAttributedText = NSAttributedString(string: "2018", attributes: attributes)
        pcv.holeRadiusPercent = 0.3
        pcv.transparentCircleRadiusPercent = 0.45
        pcv.setExtraOffsets(left: 20, top: 20, right: 20, bottom: 20)
        pcv.animate(yAxisDuration: 2)
        
        return pcv
    }()
    
    func pieChartData(values: [Double], regionValue: Double) -> PieChartData{
        let data = PieChartData()
        var pieChartEntry = [PieChartDataEntry]()
        var sortedColorsArray: [String] = []
        for i in 0..<values.count {
            if Double(values[i] / regionValue * 100) > 2 {
                sortedColorsArray.append(colors[i])
                let value = PieChartDataEntry(value: Double(values[i] / regionValue * 100).roundToPlaces(places: 2))
                pieChartEntry.append(value)
            }
        }
        let pieDataSet = PieChartDataSet(entries: pieChartEntry)
        pieDataSet.colors = hexArrayToUIColor(hexArray: sortedColorsArray)
        pieDataSet.yValuePosition = .outsideSlice
        pieDataSet.sliceSpace = 3
        pieDataSet.valueLinePart1Length = 0.9
        data.addDataSet(pieDataSet)
        data.setValueTextColor(.black)
        return data
    }
    
    func hexArrayToUIColor(hexArray: [String]) -> [UIColor] {
        var colorArray: [UIColor] = []
        for i in 0..<hexArray.count {
        colorArray.append(UIColor(hex: hexArray[i])!)
        }
        return colorArray
    }

    func setChart() {
        let vc = MainViewController.investJSON().pieCharts.districtVED
        districtChartView2016.data = pieChartData(values: vc[0].value[districtIndex], regionValue: vc[0].regionValue[districtIndex])
        districtChartView2017.data = pieChartData(values: vc[1].value[districtIndex], regionValue: vc[1].regionValue[districtIndex])
        districtChartView2018.data = pieChartData(values: vc[2].value[districtIndex], regionValue: vc[2].regionValue[districtIndex])
    }
    
    let segmentedControl: UISegmentedControl = {
        let sg = UISegmentedControl(items: ["2016", "2017", "2018"])
        sg.translatesAutoresizingMaskIntoConstraints = false
        sg.addTarget(self, action: #selector(segmentedControlChange), for: .valueChanged)
        sg.selectedSegmentIndex = 0
        return sg
    }()
    
    func percentSort(num: Int) {
        lessThan2TypeStrings.removeAll()
        newTypeStrings.removeAll()
        newColors.removeAll()
        let vc = MainViewController.investJSON().pieCharts.districtVED
        let values = vc[num].value[districtIndex]
        let regionValue = vc[num].regionValue[districtIndex]
        print(values)
        print("")
        print(regionValue)
        for i in 0..<values.count {
            if Double(values[i] / regionValue * 100) > 2 {
                newTypeStrings.append(typeStrings[i])
                newColors.append(colors[i])
            } else {
                lessThan2TypeStrings.append(typeStrings[i])
            }
        }
        tableView.reloadData()
    }
    
    @objc func segmentedControlChange(sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0:
            percentSort(num: 0)
        case 1:
            percentSort(num: 1)
        case 2:
            percentSort(num: 2)
        default:
            break
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DistrictByVEDTableViewCell.self, forCellReuseIdentifier: "districtCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.backgroundColor = UIColor(hex: "#F1E9DBFF")
        label.font = .systemFont(ofSize: 20, weight: .bold)
        switch section {
        case 0:
            label.text = "Основные виды деятельности"
        case 1:
            label.text = "Объем инвестиций менее 2% к итогу"
        default:
            label.text = ""
        }
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return newTypeStrings.count
        } else {
            return lessThan2TypeStrings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "districtCell", for: indexPath) as! DistrictByVEDTableViewCell
                   cell.typeLabel.text = newTypeStrings[indexPath.row]
                   cell.emptyView.backgroundColor = hexArrayToUIColor(hexArray: newColors)[indexPath.row]
                   cell.emptyView.layer.cornerRadius = 10
                   cell.emptyView.clipsToBounds = true
                   cell.selectionStyle = .none
                   return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "districtCell", for: indexPath) as! DistrictByVEDTableViewCell
                   cell.typeLabel.text = lessThan2TypeStrings[indexPath.row]
            cell.emptyView.backgroundColor = UIColor(hex: "#E5E3E1FF")
                   cell.emptyView.layer.cornerRadius = 10
                   cell.emptyView.clipsToBounds = true
                   cell.selectionStyle = .none
                   return cell
        }
    }
    
    let tableView: UITableView = {
        let tbv = UITableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.layer.cornerRadius = 15
        tbv.clipsToBounds = true
        tbv.separatorStyle = .none
        return tbv
    }()
    
    func setupUI() {
        view.addSubview(districtChartView2016)
        view.addSubview(districtChartView2017)
        view.addSubview(districtChartView2018)
        view.addSubview(tableView)
        view.addSubview(pieView)
        view.addSubview(segmentedControl)
        view.backgroundColor = .white
    }
    
    func setupLayout() {
        let size: CGFloat = view.frame.height * 0.4
        let step: CGFloat = 10
        NSLayoutConstraint.activate([
            districtChartView2016.heightAnchor.constraint(equalToConstant: size),
            districtChartView2016.widthAnchor.constraint(equalToConstant: size),
            districtChartView2016.topAnchor.constraint(equalTo: pieView.topAnchor, constant: step),
            districtChartView2016.leftAnchor.constraint(equalTo: pieView.leftAnchor, constant: step),
            
            districtChartView2017.heightAnchor.constraint(equalToConstant: size),
            districtChartView2017.widthAnchor.constraint(equalToConstant: size),
            districtChartView2017.rightAnchor.constraint(equalTo: pieView.rightAnchor, constant: -step),
            districtChartView2017.topAnchor.constraint(equalTo: pieView.topAnchor, constant: step),
            
            districtChartView2018.heightAnchor.constraint(equalToConstant: size),
            districtChartView2018.widthAnchor.constraint(equalToConstant: size),
            districtChartView2018.bottomAnchor.constraint(equalTo: pieView.bottomAnchor, constant: -step),
            districtChartView2018.leftAnchor.constraint(equalTo: pieView.leftAnchor, constant: step),
            
            pieView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: step),
            pieView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: step),
            pieView.rightAnchor.constraint(equalTo: tableView.leftAnchor, constant: -step),
            pieView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -step),
            
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: step),
            segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 2 + 100),
            segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -step),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: step),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width / 2 + 100),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -step),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -step)
        ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setChart()
        setupUI()
        setupLayout()
        setupTableView()
        percentSort(num: 0)
    }

}
