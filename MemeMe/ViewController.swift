//
//  ViewController.swift
//  MemeMe
//
//  Created by Cong Doan on 10/21/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import UIKit


// MARK: - ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: Properties
    let hasCamera = UIImagePickerController.isSourceTypeAvailable(.camera)
    let defaultTextTOP = "TOP"
    let defaultTextBOTTOM = "BOTTOM"
    let memeTextAttributes: [String : Any] = [
        NSAttributedStringKey.foregroundColor.rawValue : UIColor.white,
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.strokeWidth.rawValue: NSNumber(value: -3.0 as Float),
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 42)! //a decent approximation to “Impact” font
    ]


    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemShare: UIBarButtonItem!
    @IBOutlet weak var itemReset: UIBarButtonItem!
    @IBOutlet weak var itemCamera: UIBarButtonItem!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    

    // MARK: - Construct Meme object and share/save it
    func generateMemedImage() -> UIImage {
        // Hide top and bottom toolbars
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        // Render the view hierarchy into an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show top and bottom toolbars
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memedImage
    }

    func saveMeme(memedImage: UIImage) {
        if let originalImage = imageView.image, let topText = topField.text, let bottomText = bottomField.text {
            let meme = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memedImage: memedImage)
            (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
            let memes = (UIApplication.shared.delegate as! AppDelegate).memes
            print("Total number of saved memes: \(memes.count)")
        }
    }

    // MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemShare.isEnabled = false
        itemReset.isEnabled = false
        itemCamera.isEnabled = hasCamera
        
        configureTextField(topField, text: defaultTextTOP)
        configureTextField(bottomField, text: defaultTextBOTTOM)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }


    // MARK: - UI functions
    fileprivate func configureTextField(_ textField: UITextField, text: String) {
        textField.borderStyle = .none
        textField.autocapitalizationType = .allCharacters
        textField.textAlignment = .center
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = text
        textField.delegate = self
    }


    // MARK: - Methods to shift the main view up/down when the keyboard shows/hides
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        //NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // Shift the main view up when the keyboard shows
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        // Shift the main view back down when the keyboard hides
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
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
            }
        }
        self.present(activityVC, animated: true, completion: nil)
    }

    @IBAction func itemResetPressed(_ sender: Any) {
        topField.text = defaultTextTOP
        bottomField.text = defaultTextBOTTOM
        imageView.image = nil
        itemShare.isEnabled = false
        itemReset.isEnabled = false
    }


    // MARK: UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
            itemShare.isEnabled = true
            itemReset.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


    // MARK: - UITextFieldDelegate methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == topField {
            if textField.text! == defaultTextTOP {
                textField.text = ""
            }
        } else {
            if textField.text! == defaultTextBOTTOM {
                textField.text = ""
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

