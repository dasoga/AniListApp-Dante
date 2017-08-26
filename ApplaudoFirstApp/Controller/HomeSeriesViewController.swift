//
//  HomeSeriesViewController.swift
//  ApplaudoFirstApp
//
//  Created by Dante Solorio on 8/25/17.
//  Copyright © 2017 Dante Solorio. All rights reserved.
//

import UIKit

class HomeSeriesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
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
        collectionView?.register(HomeSeriesCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func getSeriesData(){
        let dataURL = "https://anilist.co/api/anime/search/original"
        var request = URLRequest(url: URL(string: dataURL)!)
        request.addValue("Bearer 6lMaxDHMRR5kaqCB3SG0V8nSnn1RuS3gzkusmsL9", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check if the response has an error
            if error != nil{
                print("Error \(String(describing: error))")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 401{
                    print("Refresh token...")
                    return
                }
            }
            
            // Get data success
            // Show collection view if everthing was success
            self.collectionView?.isHidden = false
            
            
            // Try to parse the data response
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.series = [Serie]()
                
                for dictionary in json as! [[String: Any]] {
                    // ToDo 
                    // Make this as object, not parsing manually....
                    // Parsing data manually
                    let serie = Serie()
                    serie.serieTitle = dictionary["title_english"] as? String
                    serie.serieImageURL = dictionary["image_url_med"] as? String
                    self.series?.append(serie)
                }
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.collectionView?.reloadData()
                }
            }catch let jsonError{
                print(jsonError)
            }
            
            
        }.resume()
    }

    // MARK: - CollectionView methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        identifier = cellId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeSeriesCollectionViewCell
        
        cell.serie = series?[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected \(series?[indexPath.row])")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4 + 10, height: 200)
    }
    
}
