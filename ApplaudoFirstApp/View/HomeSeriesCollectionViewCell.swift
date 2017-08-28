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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let serieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title..."
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var serie: Serie? {
        didSet{
            serieTitleLabel.text = serie?.title_english
            
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
        addSubview(titleView)
        titleView.addSubview(serieTitleLabel)
        
        
        // Configure the constraints for each element in the view
        
        // Cover image constraints cover image
        coverImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        coverImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        coverImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        coverImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        titleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        
        // Cover image constraints title label
        serieTitleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        serieTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 2).isActive = true
        serieTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 2).isActive = true
    }
    
    private func setupImage(){
        if let imageUrl = serie?.image_url_lge{
            coverImage.loadImageFromURL(urlString: imageUrl, completion: { (success) in
                if success{
                    
                }
            })
        }
    }
    
}
