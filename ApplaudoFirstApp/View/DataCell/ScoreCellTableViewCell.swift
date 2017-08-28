//
//  ScoreCellTableViewCell.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/28/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import UIKit

class ScoreCellTableViewCell: UITableViewCell {
    
    let scoreTextLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Score", comment: "")
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .blue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(scoreTextLabel)
        addSubview(scoreValueLabel)
        
        // Constraints to text label score
        scoreTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scoreTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        
        
        scoreValueLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scoreValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    
}
