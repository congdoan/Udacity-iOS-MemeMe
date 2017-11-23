//
//  SentMemesCollectionVC.swift
//  MemeMe
//
//  Created by Cong Doan on 11/21/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import UIKit


// MARK: - SentMemesCollectionVC: UICollectionViewController
class SentMemesCollectionVC: UICollectionViewController {
    
    // MARK: - Properties
    
    var appDelegate: AppDelegate!

    // MARK: - Outlets
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.shared.delegate as! AppDelegate
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeme))
        setFlowLayoutProperties(viewWidth: view.frame.size.width)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView!.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if flowLayout != nil {
            setFlowLayoutProperties(viewWidth: size.width)
            // Trigger re-layout using the newly set layout properties
            flowLayout.invalidateLayout()
        }
    }
    
    // MARK: Set the Collection View Flow Layout's Properties
    
    func setFlowLayoutProperties(viewWidth: CGFloat) {
        let spacing: CGFloat = 3.0
        let numberOfItemsInRow: CGFloat = UIDevice.current.orientation.isPortrait ? 3 : 5
        let numberOfSpacingsInRow: CGFloat = numberOfItemsInRow - 1
        let dimension = (viewWidth - (numberOfSpacingsInRow *  spacing)) / numberOfItemsInRow
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.minimumLineSpacing = spacing
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    // MARK: - Collection view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
    
        // Configure the cell
        let meme = appDelegate.memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
    
        return cell
    }

    // MARK: - Collection view delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showSelectedMeme(appDelegate.memes[indexPath.row])
    }

}
