//
//  ViewController.swift
//  Invest
//
//  Created by Max Mikhalskiy on 02/10/2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import UIKit
import Charts


let buttonStrings: [String] = ["Бокситогорский", "Волосовский", "Волховский", "Всеволожский", "Выборгский", "Гатчинский", "Кингисеппский", "Киришский", "Кировский", "Лодейнопольский", "Ломоносовский", "Лужский", "Подпорожский", "Приозерский", "Сланцевский", "Сосновоборский", "Тихвинский", "Тосненский"]
let buttonTopAnchors: [CGFloat] = [0.5592, 0.5786, 0.4381, 0.3730, 0.2470, 0.6000, 0.5518, 0.5552, 0.5052, 0.2610, 0.5000, 0.7137, 0.1875, 0.2838, 0.6621, 0.4270, 0.4394, 0.5937]
let buttonLeftAnchors: [CGFloat] = [0.7851, 0.1840, 0.5312, 0.3095, 0.1757, 0.2640, 0.0810, 0.5043, 0.3872, 0.6806, 0.1845, 0.1962, 0.7895, 0.2709, 0.0620, 0.1059, 0.7114, 0.3491]
let buttonRightAnchors: [CGFloat] = [0.9233, 0.2700, 0.6464, 0.4169, 0.2705, 0.3440, 0.1895, 0.5991, 0.5019, 0.8222, 0.2980, 0.3295, 0.9277, 0.3764, 0.1884, 0.2455, 0.8608, 0.4482]

class MainViewController: UIViewController {
    
    static func investJSON() -> InvestModel {
        let url = Bundle.main.url(forResource: "InvestJSON", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONDecoder().decode(InvestModel.self, from: data)
        return json
    }
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "mapBackground")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
//    let regionButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("Инвестиции в Ленинградскую область", for: .normal)
//        btn.backgroundColor = UIColor(hex: "#8FA6CBFF")
//        btn.tintColor = .white
//        btn.clipsToBounds = true
//        btn.layer.cornerRadius = 10
//        btn.addTarget(self, action: #selector(pushToRegion), for: .touchUpInside)
//        return btn
//    }()
//
//    let testButton: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle("Реестр инвестиционных проектов", for: .normal)
//        btn.backgroundColor = UIColor(hex: "#8FA6CBFF")
//        btn.tintColor = .white
//        btn.clipsToBounds = true
//        btn.layer.cornerRadius = 10
////        btn.addTarget(self, action: #selector(pushToRegion), for: .touchUpInside)
//        return btn
//    }()
//
//    @objc func pushToRegion(sender: UIButton!) {
//        let vc = RegionViewController()
//        let nav = self.navigationController
//        DispatchQueue.main.async {
//            nav?.view.layer.add(CATransition().segueFromBottom(), forKey: nil)
//            nav?.pushViewController(vc, animated: false)
//        }
//    }
    
    @objc func pushToDistrict(sender: UIButton!) {
        let vc = DistrictViewController()
        if sender.titleLabel?.text == "Сосновоборский" {
            vc.title = "\(sender.titleLabel?.text ?? "") городской округ"
        } else {
            vc.title = "\(sender.titleLabel?.text ?? "") район"
        }
        vc.districtArray = MainViewController.investJSON().lineCharts.main[sender.tag]
        vc.districtIndex = sender.tag
        let nav = self.navigationController
        DispatchQueue.main.async {
            nav?.hidesBottomBarWhenPushed = false
            nav?.pushViewController(vc, animated: true)
        }
    }
    
    func setButtons() {
        for i in 0..<buttonStrings.count {
            let btn = UIButton(type: .system)
            btn.tag = i
            btn.setTitle(buttonStrings[i], for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.titleLabel?.textAlignment = .left
            btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.addTarget(self, action: #selector(pushToDistrict), for: .touchUpInside)
            view.addSubview(btn)
            
            NSLayoutConstraint.activate([
                btn.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * buttonTopAnchors[i]),
                btn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * buttonLeftAnchors[i]),
                btn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.frame.width * (1 - buttonRightAnchors[i])),
                btn.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }
    
    func setupUI() {
        view.addSubview(backgroundImageView)
//        view.addSubview(regionButton)
//        view.addSubview(testButton)
        view.backgroundColor = .white
    }
    
    func setupLayout() {
        let topSpacing = view.safeAreaLayoutGuide.topAnchor
        let avgSpacing: CGFloat = 25
        
        NSLayoutConstraint.activate([
            backgroundImageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.75),
            backgroundImageView.topAnchor.constraint(equalTo: topSpacing, constant: view.frame.height * 0.025),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width * 0.025),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.frame.width * 0.025),
            
//            regionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: avgSpacing),
//            regionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
//            regionButton.heightAnchor.constraint(equalToConstant: 44),
//            regionButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.46),
//
//            testButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -avgSpacing),
//            testButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
//            testButton.heightAnchor.constraint(equalToConstant: 44),
//            testButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.46)
        ])
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    if let touch = touches.first {
//        let location = touch.location(in: self.view)
//        print("width")
//        print(location.x / view.frame.width)
//        print("top")
//        print(location.y / view.frame.height)
//      }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Инвестиционная деятельность на территории Ленинградской области"
        setupUI()
        setupLayout()
        setButtons()
    }
    
    func mainButton(sender: UIButton) {
    }

}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

extension CATransition {

//New viewController will appear from bottom of screen.
func segueFromBottom() -> CATransition {
    self.duration = 0.4 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.push
    self.subtype = CATransitionSubtype.fromTop
    return self
}
//New viewController will appear from top of screen.
func segueFromTop() -> CATransition {
    self.duration = 0.375 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromBottom
    return self
}
 //New viewController will appear from left side of screen.
func segueFromLeft() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromLeft
    return self
}
//New viewController will pop from right side of screen.
func popFromRight() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.reveal
    self.subtype = CATransitionSubtype.fromRight
    return self
}
//New viewController will appear from left side of screen.
func popFromLeft() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.reveal
    self.subtype = CATransitionSubtype.fromLeft
    return self
   }
}
