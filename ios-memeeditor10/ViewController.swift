//
//  ViewController.swift
//  ios-memeeditor10
//
//  Created by Philipp Herzig on 06.11.16.
//  Copyright © 2016 Philipp Herzig. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Actions

    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        let destinationController = UIImagePickerController()
        destinationController.delegate = self
        present(destinationController, animated: true, completion: nil)
    }
    
    @IBAction func makeImage(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func shareImage(_ sender: UIBarButtonItem) {
    }
    
    // MARK: Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

}

