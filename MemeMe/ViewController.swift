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
        NSAttributedStringKey.foregroundColor.rawValue : UIColor.white, //NSColor; NSForegroundColorAttributeName ok too
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black, //NSStrokeColor; NSStrokeColorAttributeName ok too
        NSAttributedStringKey.strokeWidth.rawValue: 3, //NSStrokeWidth; NSStrokeWidthAttributeName ok too
        // a decent approximation to “Impact.”
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)! // NSFont; NSFontAttributeName ok too
    ]
    
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolbarItemCamera: UIBarButtonItem!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    
    // MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolbarItemCamera.isEnabled = hasCamera
        
        topField.text = defaultTextTOP
        topField.autocapitalizationType = .allCharacters
        topField.defaultTextAttributes = memeTextAttributes
        topField.textAlignment = .center
        topField.delegate = self
        
        bottomField.text = defaultTextBOTTOM
        bottomField.autocapitalizationType = .allCharacters
        bottomField.defaultTextAttributes = memeTextAttributes
        bottomField.textAlignment = .center
        bottomField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: - Methods to shift the main view up when the keyboard appears
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
    
    // MARK: UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
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

