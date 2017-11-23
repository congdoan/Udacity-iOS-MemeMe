//
//  MemeEditorVC+Keyboard.swift
//  MemeMe
//
//  Created by Cong Doan on 10/24/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import Foundation
import UIKit


// MARK: - MemeEditorVC: Keyboard Show/Hide Events Handling
extension MemeEditorVC {

    // MARK: - Methods to slide the main view up/down when the keyboard shows/hides
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
        if bottomField.isFirstResponder {
            // Slide the main view up when the keyboard shows
            // https://discussions.udacity.com/t/better-way-to-shift-the-view-for-keyboardwillshow-and-keyboardwillhide/36558?u=coolshubh4
            self.view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if bottomField.isFirstResponder {
            // Shift the main view back down when the keyboard hides
            self.view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

}
