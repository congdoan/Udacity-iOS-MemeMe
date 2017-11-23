//
//  SentMemesTableVC.swift
//  MemeMe
//
//  Created by Cong Doan on 11/21/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import UIKit

class SentMemesTableVC: UITableViewController {

    // MARK: Properties
    
    var memes: [Meme]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        // Add rightBarButtonItem to navigationItem
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
    
    // MARK: Add new Meme
    
    @objc func addMeme() {
        // Grab the detail View Controller from Storyboard
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        // Pressent it using navigation
        navigationController?.pushViewController(detailVC, animated: true)
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
        // Grab the detail View Controller from Storyboard
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        // Populate it with the data from the selected item
        detailVC.meme = memes[indexPath.row]
        
        // Pressent it using navigation
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
