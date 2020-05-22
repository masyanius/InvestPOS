//
//  RegistryTableViewCell.swift
//  Invest
//
//  Created by Max Mikhalskiy on 19.02.2020.
//  Copyright © 2020 Max Mikhalskiy. All rights reserved.
//

import UIKit


class RegistryTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(projectLabel)
        self.contentView.addSubview(investorLabel)
        self.contentView.addSubview(sectorLabel)
        self.contentView.addSubview(investmentSizeLabel)
        
        NSLayoutConstraint.activate([
            projectLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            projectLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            projectLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
            projectLabel.heightAnchor.constraint(equalToConstant: 40),
            
            investorLabel.topAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 1),
            investorLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            investorLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
            investorLabel.heightAnchor.constraint(equalToConstant: 40),
            
            sectorLabel.topAnchor.constraint(equalTo: investorLabel.bottomAnchor, constant: 1),
            sectorLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            sectorLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
            sectorLabel.heightAnchor.constraint(equalToConstant: 40),
            
            investmentSizeLabel.topAnchor.constraint(equalTo: sectorLabel.bottomAnchor, constant: 1),
            investmentSizeLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            investmentSizeLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
            investmentSizeLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
     }
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    let projectLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let investorLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let sectorLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let investmentSizeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
}
