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
    
    var appDelegate: AppDelegate!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.shared.delegate as! AppDelegate
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeme))
        tableView.rowHeight = 106.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell

        // Configure the cell
        let meme = appDelegate.memes[indexPath.row]
        cell.memeImageView.image = meme.memedImage
        cell.memeTextLabel.text = "\(meme.topText) ... \(meme.bottomText)"

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            appDelegate.memes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showSelectedMeme(appDelegate.memes[indexPath.row])
    }
    
}
