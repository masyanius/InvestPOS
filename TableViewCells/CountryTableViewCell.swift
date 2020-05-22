//
//  CountryTableViewCell.swift
//  Invest
//
//  Created by Max Mikhalskiy on 28.11.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import UIKit


class CountryTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(yearLabel)
        self.contentView.addSubview(valueLabel)
        self.contentView.addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            yearLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            yearLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            yearLabel.rightAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: -5),
            yearLabel.heightAnchor.constraint(equalToConstant: 40),
            
            valueLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            valueLabel.leftAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 5),
            valueLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
            valueLabel.heightAnchor.constraint(equalToConstant: 40),
            
            dividerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            dividerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dividerView.widthAnchor.constraint(equalToConstant: 1),
            dividerView.heightAnchor.constraint(equalToConstant: 30)
        ])
     }
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    let yearLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let valueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
}
