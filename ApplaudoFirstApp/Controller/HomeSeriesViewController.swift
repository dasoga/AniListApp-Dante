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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: - Private functions
    
    private func setupView(){
//        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
//            flowLayout.scrollDirection = .horizontal
//            flowLayout.minimumLineSpacing = 0
//        }
        
        
        collectionView?.backgroundColor = .white
        collectionView?.register(HomeSeriesCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }

    // MARK: - CollectionView methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        identifier = cellId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4 + 10, height: 200)
    }
    
    
}
