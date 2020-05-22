//
//  StructureByCountryViewController.swift
//  Invest
//
//  Created by Max Mikhalskiy on 16.11.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import UIKit


class StructureByCountryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var valueArray: [Double] = []
    
    let tableView: UITableView = {
        let tbv = UITableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        tbv.layer.cornerRadius = 15
        tbv.clipsToBounds = true
        tbv.isUserInteractionEnabled = false
        return tbv
    }()
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "countryCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewController.investJSON().lineCharts.structureByCountry[0].years.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        cell.yearLabel.text = MainViewController.investJSON().lineCharts.structureByCountry[0].years[indexPath.row]
        cell.valueLabel.text = "\(valueArray[indexPath.row].roundToPlaces(places: 2))%"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    private let countryView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.layer.zPosition = 1
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let countryLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tag = -1
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Закрыть", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = .systemFont(ofSize: 20)
        btn.backgroundColor = UIColor(hex: "#8FA6CBFF")
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(showHide), for: .touchUpInside)
        return btn
    }()
    
    func convertNumbersToPercentOf(numbers: [Double]) -> [Double] {
        var array: [Double] = []
        for i in 0..<numbers.count {
            let value = numbers[i] / MainViewController.investJSON().lineCharts.structureByCountry[0].regionValue[i] * 100
            array.append(value)
        }
        return array
    }
    
    @objc func showHide(sender: UIButton!) {
        if sender.tag != -1 {
            countryLabel.text = sender.titleLabel?.text
            valueArray = convertNumbersToPercentOf(numbers: MainViewController.investJSON().lineCharts.structureByCountry[0].value[sender.tag])
            setupTableView()
            tableView.reloadData()
        }
        
        if countryView.isHidden == false {
            countryView.setIsHidden(true, animated: true)
        } else {
            countryView.setIsHidden(false, animated: true)
        }
        
    }
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "StructureBackground")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()
    
    let buttonTitle: [String] = ["Австрия", "Беларусь", "Германия", "Дания", "Италия", "Казахстан", "Кипр", "Китай", "Нидерланды", "Таджикистан", "Узбекистан", "Украина", "Финляндия", "Швейцария"]
    let buttonTopAnchor: [CGFloat] = [0.5628, 0.4343, 0.5026, 0.3821, 0.6751, 0.5390, 0.8007, 0.7408, 0.4636, 0.7333, 0.6557, 0.5400, 0.1946, 0.5872]
    let buttonLeftAnchor: [CGFloat] = [0.2129, 0.3391, 0.1658, 0.1690, 0.2026, 0.6531, 0.3727, 0.8698, 0.1162, 0.6584, 0.5804, 0.3660, 0.2955, 0.1196]
    
    func setButtons() {
        for i in 0..<buttonTitle.count {
            let btn = UIButton(type: .system)
            btn.tag = i
            btn.setTitle("\(buttonTitle[i])\n\(convertNumbersToPercentOf(numbers: MainViewController.investJSON().lineCharts.structureByCountry[0].value[i])[3].roundToPlaces(places: 2))%", for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.titleLabel?.lineBreakMode = .byWordWrapping
            btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.textAlignment = .center
            btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.addTarget(self, action: #selector(showHide), for: .touchUpInside)
            view.addSubview(btn)
            NSLayoutConstraint.activate([
                btn.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * (buttonTopAnchor[i] - 0.03)),
                btn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * buttonLeftAnchor[i]),
                btn.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(countryView)
        countryView.addSubview(countryLabel)
        countryView.addSubview(tableView)
        countryView.addSubview(closeButton)
        view.backgroundColor = .white
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.025),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * 0.025),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.frame.width * 0.025),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.height * 0.025),
            
            countryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            countryView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 350),
            countryView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -350),
            countryView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            
            countryLabel.topAnchor.constraint(equalTo: countryView.topAnchor, constant: 10),
            countryLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -10),
            countryLabel.leftAnchor.constraint(equalTo: countryView.leftAnchor, constant: 10),
            countryLabel.rightAnchor.constraint(equalTo: countryView.rightAnchor, constant: -10),
            countryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: countryView.leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: countryView.rightAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -10),
            
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.bottomAnchor.constraint(equalTo: countryView.bottomAnchor, constant: -10)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Структура инвестиций по странам"
        setupUI()
        setupLayout()
        setButtons()
    }

}

extension Double {
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIView {
    func setIsHidden(_ hidden: Bool, animated: Bool) {
        if animated {
            if self.isHidden && !hidden {
                self.alpha = 0.0
                self.isHidden = false
            }
            UIView.animate(withDuration: 0.25, animations: {
                self.alpha = hidden ? 0.0 : 1.0
            }) { (complete) in
                self.isHidden = hidden
            }
        } else {
            self.isHidden = hidden
        }
    }
}
