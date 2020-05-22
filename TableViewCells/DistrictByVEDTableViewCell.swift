//
//  DistrictByVEDTableViewCell.swift
//  Invest
//
//  Created by Max Mikhalskiy on 13.12.2019.
//  Copyright © 2019 Max Mikhalskiy. All rights reserved.
//

import UIKit


class DistrictByVEDTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        emptyView.addSubview(typeLabel)
        self.contentView.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2),
            emptyView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 2),
            emptyView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -2),
            emptyView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2),
            emptyView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            typeLabel.topAnchor.constraint(equalTo: self.emptyView.topAnchor, constant: 3),
            typeLabel.leftAnchor.constraint(equalTo: self.emptyView.leftAnchor, constant: 3),
            typeLabel.rightAnchor.constraint(equalTo: self.emptyView.rightAnchor, constant: -3),
            typeLabel.bottomAnchor.constraint(equalTo: self.emptyView.bottomAnchor, constant: -3)
        ])
     }
     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    let typeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 17)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
