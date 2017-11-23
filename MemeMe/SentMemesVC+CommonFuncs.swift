//
//  SentMemesVC+CommonFuncs.swift
//  MemeMe
//
//  Created by Cong Doan on 11/23/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import Foundation
import UIKit


// MARK: - UIViewController: Common Functions used by SentMemesTableVC and SentMemesCollectionVC
extension UIViewController {

    // MARK: Show the Meme Editor View Controller
    
    @objc func addMeme() {
        // Grab the Meme Editor View Controller from Storyboard
        let memeEditorVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorVC
        // Pressent it modally
        present(memeEditorVC, animated: true, completion: nil)
    }
    
    // MARK: Show the Meme Detail View Controller
    
    func showSelectedMeme(_ meme: Meme) {
        // Grab the Meme Detail View Controller from Storyboard
        let memeDetailVC = storyboard?.instantiateViewController(withIdentifier: "MemeDetailVC") as! MemeDetailVC
        // Populate it with the data from the selected item
        memeDetailVC.meme = meme
        // Pressent it using navigation
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }

    
}


