//
//  RegistryProjectsViewController.swift
//  Invest
//
//  Created by Max Mikhalskiy on 11.02.2020.
//  Copyright © 2020 Max Mikhalskiy. All rights reserved.
//

import UIKit
import Foundation


class RegistryProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    let path = MainViewController.investJSON().registry
    var filter : (project: String, investor: String, sector: String, minPrice: Int, maxPrice: Int) = ("","","",0,0)
    
    // MARK: - TableView
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RegistryTableViewCell.self, forCellReuseIdentifier: "registryCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        path.project.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registryCell", for: indexPath) as! RegistryTableViewCell
        cell.projectLabel.text = "Проект: \(path.project[indexPath.row])"
        cell.investorLabel.text = "Инвестор: \(path.investor[indexPath.row])"
        cell.sectorLabel.text = "Вид деятельности: \(path.sector[indexPath.row])"
        cell.investmentSizeLabel.text = "Объем инвестиций: \(String(path.investmentSize[indexPath.row])) млн руб."
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    let tableView: UITableView = {
        let tbv = UITableView()
        tbv.translatesAutoresizingMaskIntoConstraints = false
        return tbv
    }()
    
    let filterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.isHidden = true
        view.backgroundColor = UIColor(hex: "#EAE6E9FF")
        return view
    }()
    
    // MARK: - PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let array = path.sector.removingDuplicates()
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = path.sector.removingDuplicates()[row]
        label.sizeToFit()
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        filter.sector = path.sector.removingDuplicates()[row]
    }
    
    let pickerViewSector: UIPickerView = {
        let pv = UIPickerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    func setupPickerView() {
        pickerViewSector.dataSource = self
        pickerViewSector.delegate = self
    }
    
    // MARK: - TextFields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil) {
            return true
        } else {
            return false
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let minPrice = Int(minPriceTextField.text ?? "") {
            filter.minPrice = minPrice
        }
        if let maxPrice = Int(maxPriceTextField.text ?? "") {
            filter.maxPrice = maxPrice
        }
    }
    
    func setupTextFields() {
        minPriceTextField.delegate = self
        maxPriceTextField.delegate = self
    }
    
    let projectTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Название проекта"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(RegistryProjectsViewController.textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    let investorTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Название инвестора"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(RegistryProjectsViewController.textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    let minPriceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Минимальная цена"
        tf.keyboardType = .numberPad
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(RegistryProjectsViewController.textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    let maxPriceTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Максимальная цена"
        tf.keyboardType = .numberPad
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(RegistryProjectsViewController.textFieldDidChange(_:)), for: .editingChanged)
        return tf
    }()
    
    func filtering() {
        print(path.project.indexes(of: "зав"))
    }
    
    func setupUI() {
        view.addSubview(tableView)
        filterView.addSubview(projectTextField)
        filterView.addSubview(investorTextField)
        filterView.addSubview(pickerViewSector)
        filterView.addSubview(minPriceTextField)
        filterView.addSubview(maxPriceTextField)
        view.addSubview(filterView)
        view.backgroundColor = .white
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            filterView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5),
            filterView.heightAnchor.constraint(equalToConstant: 270),
            filterView.widthAnchor.constraint(equalToConstant: 500),
            
            projectTextField.topAnchor.constraint(equalTo: filterView.topAnchor, constant: 5),
            projectTextField.leftAnchor.constraint(equalTo: filterView.leftAnchor, constant: 5),
            projectTextField.rightAnchor.constraint(equalTo: filterView.rightAnchor, constant: -5),
            projectTextField.heightAnchor.constraint(equalToConstant: 40),
            
            investorTextField.topAnchor.constraint(equalTo: projectTextField.bottomAnchor, constant: 5),
            investorTextField.leftAnchor.constraint(equalTo: filterView.leftAnchor, constant: 5),
            investorTextField.rightAnchor.constraint(equalTo: filterView.rightAnchor, constant: -5),
            investorTextField.heightAnchor.constraint(equalToConstant: 40),
            
            pickerViewSector.topAnchor.constraint(equalTo: investorTextField.bottomAnchor, constant: 5),
            pickerViewSector.leftAnchor.constraint(equalTo: filterView.leftAnchor, constant: 5),
            pickerViewSector.rightAnchor.constraint(equalTo: filterView.rightAnchor, constant: -5),
            pickerViewSector.heightAnchor.constraint(equalToConstant: 80),
            
            minPriceTextField.topAnchor.constraint(equalTo: pickerViewSector.bottomAnchor, constant: 5),
            minPriceTextField.leftAnchor.constraint(equalTo: filterView.leftAnchor, constant: 5),
            minPriceTextField.rightAnchor.constraint(equalTo: filterView.centerXAnchor, constant: -10),
            minPriceTextField.heightAnchor.constraint(equalToConstant: 40),
            
            maxPriceTextField.topAnchor.constraint(equalTo: pickerViewSector.bottomAnchor, constant: 5),
            maxPriceTextField.leftAnchor.constraint(equalTo: filterView.centerXAnchor, constant: 10),
            maxPriceTextField.rightAnchor.constraint(equalTo: filterView.rightAnchor, constant: -5),
            maxPriceTextField.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    @objc func rightBarButton() {
        if filterView.isHidden == false {
            filterView.setIsHidden(true, animated: true)
        } else {
            filterView.setIsHidden(false, animated: true)
        }
    }
    
    func setupNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Фильтр", style: .plain, target: self, action: #selector(rightBarButton))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
        setupTableView()
        setupNavBar()
        setupPickerView()
        setupTextFields()
        filtering()
    }

}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension Array where Element == String {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter { $0.element.lowercased().contains(element)}.map({ $0.offset })
    }
}
