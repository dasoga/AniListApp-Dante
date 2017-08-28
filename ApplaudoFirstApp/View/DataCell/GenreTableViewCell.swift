//
//  GenreTableViewCell.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/28/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    let genreTextLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Genres:", comment: "")
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .gray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
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
        addSubview(genreTextLabel)
        addSubview(genreValueLabel)
        
        // Constraints to text label score
        genreTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        genreTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        genreTextLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -4).isActive = true
        genreTextLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        genreValueLabel.topAnchor.constraint(equalTo: genreTextLabel.bottomAnchor, constant: 8).isActive = true
        genreValueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        genreValueLabel.leftAnchor.constraint(equalTo: genreTextLabel.leftAnchor).isActive = true
        genreValueLabel.rightAnchor.constraint(equalTo: genreTextLabel.rightAnchor).isActive = true
        
    }
}
