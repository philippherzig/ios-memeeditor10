//
//  ViewController.swift
//  ios-memeeditor10
//
//  Created by Philipp Herzig on 06.11.16.
//  Copyright © 2016 Philipp Herzig. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.delegate = self
        bottomTextField.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    // MARK: Actions

    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        let destinationController = UIImagePickerController()
        destinationController.delegate = self
        present(destinationController, animated: true, completion: nil)
    }
    
    @IBAction func makeImage(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let destinationController = UIImagePickerController()
            destinationController.delegate = self
            destinationController.sourceType = UIImagePickerControllerSourceType.camera
            destinationController.allowsEditing = false
            self.present(destinationController, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareImage(_ sender: UIBarButtonItem) {
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let destinationController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        present(destinationController, animated: true, completion: nil)
    }
    
    // MARK: Image Picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Textfield Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Keyboard Movement
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func getKeyboardHeight(notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillShow(notification: Notification) {
        if bottomTextField.isEditing {
            self.view.window?.frame.origin.y = -1 * getKeyboardHeight(notification: notification)
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        if self.view.window?.frame.origin.y != 0 {
            self.view.window?.frame.origin.y += getKeyboardHeight(notification: notification)
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

}

