//
//  SentMemesCollectionVCCollectionViewController.swift
//  MemeMe
//
//  Created by Cong Doan on 11/21/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import UIKit


class SentMemesCollectionVC: UICollectionViewController {
    
    // MARK: Properties
    
    var memes: [Meme]!
    
    // MARK: Outlets
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeme))
        
        setFlowLayoutProperties(viewWidth: view.frame.size.width)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Initialize memes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        // Refresh
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
    
    private func setFlowLayoutProperties(viewWidth: CGFloat) {
        let spacing: CGFloat = 3.0
        let numberOfItemsInRow: CGFloat = UIDevice.current.orientation.isPortrait ? 3 : 5
        let numberOfSpacingsInRow: CGFloat = numberOfItemsInRow - 1
        let dimension = (viewWidth - (numberOfSpacingsInRow *  spacing)) / numberOfItemsInRow
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.minimumLineSpacing = spacing
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    // MARK: Add new Meme
    
    @objc func addMeme() {
        // Grab the Meme Editor View Controller from Storyboard
        let memeEditorVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorVC
        // Pressent it modally
        present(memeEditorVC, animated: true, completion: nil)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
    
        // Configure the cell
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Grab the Meme Detail View Controller from Storyboard
        let memeDetailVC = storyboard?.instantiateViewController(withIdentifier: "MemeDetailVC") as! MemeDetailVC
        // Populate it with the data from the selected item
        memeDetailVC.meme = memes[indexPath.row]
        // Pressent it using navigation
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }

}
