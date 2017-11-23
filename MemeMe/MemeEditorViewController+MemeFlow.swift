//
//  MemeEditorViewController+MemeFlow.swift
//  MemeMe
//
//  Created by Cong Doan on 10/24/17.
//  Copyright © 2017 Cong Doan. All rights reserved.
//

import Foundation
import UIKit


// MARK: - MemeEditorViewController: Meme Workflow related Functions
extension MemeEditorViewController {

    // MARK: - Construct Meme object and share/save it
    func generateMemedImage() -> UIImage {
        // Hide top and bottom toolbars
        toggleVisibilityOfToolbars(invisible: true)
        
        // Render the view hierarchy into an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show top and bottom toolbars
        toggleVisibilityOfToolbars(invisible: false)
        
        return memedImage
    }
    
    func saveMeme(memedImage: UIImage) {
        if let originalImage = imageView.image, let topText = topField.text, let bottomText = bottomField.text {
            let meme = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memedImage: memedImage)
            //(UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
            //TEST
            for _ in 1...4 {
                (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
            }
        }
    }

    // MARK: Little helper function
    func toggleVisibilityOfToolbars(invisible: Bool) {
        topToolbar.isHidden = invisible
        bottomToolbar.isHidden = invisible
    }

}
