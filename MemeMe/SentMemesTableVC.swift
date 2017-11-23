//
//  SentMemesTableVC.swift
//  MemeMe
//
//  Created by Cong Doan on 11/21/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import UIKit


// MARK: - SentMemesTableVC: UITableViewController
class SentMemesTableVC: UITableViewController {

    // MARK: - Properties
    
    var memes: [Meme]!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeme))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Initialize memes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        // Refresh
        tableView.reloadData()
        
        tableView.rowHeight = 100.0
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell

        // Configure the cell
        let meme = memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        cell.memeTextLabel.text = "\(meme.topText) ... \(meme.bottomText)"

        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showSelectedMeme(memes[indexPath.row])
    }

}
