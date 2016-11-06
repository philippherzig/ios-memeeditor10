//
//  ViewController.swift
//  ios-memeeditor10
//
//  Created by Philipp Herzig on 06.11.16.
//  Copyright © 2016 Philipp Herzig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        let destinationController = UIImagePickerController()
        present(destinationController, animated: true, completion: nil)
    }
    
    @IBAction func makeImage(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func shareImage(_ sender: UIBarButtonItem) {
    }

}

