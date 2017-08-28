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
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
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
    
    let serieTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Serie name"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dataTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var serieSelected: Serie? {
        didSet{
            
            serieTitleLabel.text = serieSelected?.title_english
            
            // Download banner image, otherwise downlaod large image
            if let imageBannerUrl = serieSelected?.image_url_banner{
                coverImageView.loadImageFromURL(urlString: imageBannerUrl, completion: { (success) in
                    if success{
                        self.activityIndicator.stopAnimating()
                    }
                })
            }else if let imageUrlString = serieSelected?.image_url_lge{
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
        title = serieSelected?.series_type
        
        // Add subviews
        view.addSubview(coverImageView)
        view.addSubview(serieTitleLabel)
        view.addSubview(activityIndicator)
        view.addSubview(dataTable)
        
        // Add constraints
        coverImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        coverImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // Center the activity indicator into cover image view
        activityIndicator.centerXAnchor.constraint(equalTo: coverImageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor).isActive = true
        
        // Position of title label just after cover image
        serieTitleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 8).isActive = true
        serieTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        serieTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        serieTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Constraints for data table
        dataTable.topAnchor.constraint(equalTo: serieTitleLabel.bottomAnchor, constant: 8).isActive = true
        dataTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        dataTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        dataTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
}



extension DetailViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            if let score = serieSelected?.average_score{
                let scoreCell = ScoreCellTableViewCell()
                scoreCell.scoreValueLabel.text = "\(score)"
                return scoreCell
            }
        case 1:
            if let genres = serieSelected?.genres{
                let genreCell = GenreTableViewCell()
                let genresString = genres.flatMap({$0}).joined(separator: ", ")
                genreCell.genreValueLabel.text = genresString
                return genreCell
            }
        case 2:
            if let episodes = serieSelected?.totalEpisodes, let duration = serieSelected?.duration{
                cell.textLabel?.text = "\(String(describing: episodes)) / \(duration) min"
            }
        default:
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 60
        }else if indexPath.row == 1{
            return 100
        }
        return 50
    }
}
