//
//  HomeSeriesViewController.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/25/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import UIKit

class HomeSeriesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//         Example of data
//    var series: [Serie] = {
//        var exampleSerie = Serie()
//        exampleSerie.serieTitle = "Example of serie title to show in cell"
//        exampleSerie.serieImageURL = "No image"
//        return [exampleSerie]
//    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let acIn = UIActivityIndicatorView()
        acIn.color = .black
        acIn.startAnimating()
        acIn.hidesWhenStopped = true
        acIn.translatesAutoresizingMaskIntoConstraints = false
        return acIn
    }()
    

    var series: [Serie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getSeriesData()
    }
    
    // MARK: - Private functions
    
    private func setupView(){
        title = "Anime"
        view.backgroundColor = .white
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        collectionView?.isHidden = true
        collectionView?.backgroundColor = .white
        collectionView?.register(HomeSeriesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CELL_ID)
    }
    
    private func getSeriesData(){
        Request.shared.getSeriesData { (series) in
            if let seriesResult = series{
                self.series = seriesResult
                self.activityIndicator.stopAnimating()
                self.collectionView?.isHidden = false
                self.collectionView?.reloadData()
            }
        }
    }


    // MARK: - CollectionView methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        identifier = Constants.CELL_ID
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeSeriesCollectionViewCell
        
        cell.serie = series?[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected \(String(describing: series?[indexPath.row]))")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4 + 10, height: 200)
    }
    
}
