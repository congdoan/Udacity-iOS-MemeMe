//
//  MemeEditorVC.swift
//  MemeMe
//
//  Created by Cong Doan on 10/21/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import UIKit


// MARK: - MemeEditorVC: UIViewController
class MemeEditorVC: UIViewController {

    // MARK: - Properties
    let hasCamera = UIImagePickerController.isSourceTypeAvailable(.camera)
    let defaultTextTOP = "TOP"
    let defaultTextBOTTOM = "BOTTOM"
    let memeTextAttributes: [String : Any] = [
        NSAttributedStringKey.foregroundColor.rawValue : UIColor.white,
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.strokeWidth.rawValue: NSNumber(value: -3.0 as Float),
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 42)! //a decent approximation to “Impact” font
    ]
    
    var meme: Meme?


    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemShare: UIBarButtonItem!
    @IBOutlet weak var itemCancel: UIBarButtonItem!
    @IBOutlet weak var itemCamera: UIBarButtonItem!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    

    // MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemCamera.isEnabled = hasCamera
        
        if let meme = self.meme {
            configureTextField(topField, text: meme.topText)
            imageView.image = meme.originalImage
            configureTextField(bottomField, text: meme.bottomText)
        } else {
            itemShare.isEnabled = false
            configureTextField(topField, text: defaultTextTOP)
            configureTextField(bottomField, text: defaultTextBOTTOM)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        
        // Hide nav and tab bars
        setHiddenStateOfBars(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
        
        // Show nav and tab bars
        setHiddenStateOfBars(false)
    }


    // MARK: - UI functions
    private func setHiddenStateOfBars(_ isHidden: Bool) {
        navigationController?.isNavigationBarHidden = isHidden
        tabBarController?.tabBar.isHidden = isHidden
    }
    
    private func configureTextField(_ textField: UITextField, text: String) {
        textField.borderStyle = .none
        textField.autocapitalizationType = .allCharacters
        textField.defaultTextAttributes = memeTextAttributes
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 28
        textField.textAlignment = .center
        textField.text = text
        textField.delegate = self
    }


    // MARK: - Actions
    @IBAction func pickImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType(rawValue: (sender as! UIBarItem).tag)!
        if imagePicker.sourceType == .photoLibrary && !hasCamera {
            imagePicker.sourceType = .savedPhotosAlbum
        }
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func shareMeme(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityVC.completionWithItemsHandler = {activity, success, items, error in
            if success && error == nil {
                self.saveMeme(memedImage: memedImage)
                
                // Dismiss the meme editor view controller
                self.dismiss(animated: true, completion: nil)
            }
        }
        present(activityVC, animated: true, completion: nil)
    }

    @IBAction func itemCancelPressed(_ sender: Any) {
        // Dismiss the meme editor view controller
        dismiss(animated: true, completion: nil)
    }

}

