//
//  HomeSeriesCollectionViewCell.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/25/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import UIKit

class HomeSeriesCollectionViewCell: UICollectionViewCell {
    
    let coverImage: CustomCoverSerieImage = {
        let imageView = CustomCoverSerieImage()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let serieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title..."
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var serie: Serie? {
        didSet{
            serieTitleLabel.text = serie?.serieTitle
            
            setupImage()
        }
    }
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(){
        //Add all elements to cell view.
        addSubview(coverImage)
        addSubview(serieTitleLabel)
        
        
        // Configure the constraints for each element in the view
        
        // Cover image constraints cover image
        coverImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        coverImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        coverImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        coverImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        // Cover image constraints title label
        serieTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        serieTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        serieTitleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        serieTitleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    private func setupImage(){
        if let imageUrl = serie?.serieImageURL{
            coverImage.loadImageFromURL(urlString: imageUrl)
        }
    }
    
}
