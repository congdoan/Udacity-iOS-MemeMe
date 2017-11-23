//
//  MemeEditorVC+Delegates.swift
//  MemeMe
//
//  Created by Cong Doan on 10/24/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import Foundation
import UIKit


// MARK: - MemeEditorVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
extension MemeEditorVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
            itemShare.isEnabled = true
            itemCancel.isEnabled = true
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
        itemCancel.isEnabled = (topField.text! != defaultTextTOP) || (bottomField.text! != defaultTextBOTTOM)
        return true
    }
    
}
