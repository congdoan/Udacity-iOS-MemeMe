//
//  MemeDetailVC.swift
//  MemeMe
//
//  Created by Cong Doan on 11/23/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import UIKit

class MemeDetailVC: UIViewController {
    
    // MARK: Properties
    
    var meme: Meme!
    
    // MARK: Outlets
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        memeImageView.image = meme.memedImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editMeme))
    }
    
    // MARK: Edit Meme
    
    @objc func editMeme() {
        // Grab the Meme Editor View Controller from Storyboard
        let memeEditorVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorVC") as! MemeEditorVC
        // Populate it
        memeEditorVC.meme = meme
        // Pressent it modally
        present(memeEditorVC, animated: true, completion: nil)
        
        // Pop the Meme Detail View Controller off the Navigation stack
        navigationController?.popViewController(animated: true)
    }

}
