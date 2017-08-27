//
//  DetailViewController.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/27/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let coverImageView: CustomCoverSerieImage = {
        let iv = CustomCoverSerieImage()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let acIn = UIActivityIndicatorView()
        acIn.color = .black
        acIn.startAnimating()
        acIn.hidesWhenStopped = true
        acIn.translatesAutoresizingMaskIntoConstraints = false
        return acIn
    }()
    
    let serieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var serieSelected: Serie? {
        didSet{
            
            serieDescriptionLabel.text = serieSelected?.serieTitle
            
            if let imageUrlString = serieSelected?.serieLargeImageURL{
                coverImageView.loadImageFromURL(urlString: imageUrlString, completion: { (success) in
                    if success{
                        self.activityIndicator.stopAnimating()
                    }
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .white
        
        // Add subviews
        view.addSubview(coverImageView)
        view.addSubview(serieDescriptionLabel)
        view.addSubview(activityIndicator)
        
        // Add constraints
        coverImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        coverImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        // Center the activity indicator into cover image view
        activityIndicator.centerXAnchor.constraint(equalTo: coverImageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor).isActive = true
        
        // Position of title label just after cover image
        serieDescriptionLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor).isActive = true
        serieDescriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        serieDescriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        serieDescriptionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    

}
