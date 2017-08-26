//
//  HomeSeriesCollectionViewCell.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/25/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import UIKit

class HomeSeriesCollectionViewCell: UICollectionViewCell {
    
    let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(){
        addSubview(coverImage)
        coverImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        coverImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        coverImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        coverImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
}
