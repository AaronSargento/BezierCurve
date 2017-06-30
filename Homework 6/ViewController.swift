//
//  ViewController.swift
//  Homework 6
//
//  Created by Aaron Sargento on 2/23/17.
//  Copyright © 2017 Aaron Sargento. All rights reserved.
//

// Input: There is no input.
// Output: Program formats the objects in the viewController.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var addSomething: UIButton!
    
    @IBOutlet weak var ResetButton: UIButton!
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myTextView: UITextView!
    
    @IBOutlet weak var DisplayButton: UIButton!
    
    @IBOutlet weak var ClearButton: UIButton!
    
    /*
        This function will format the buttons
    */
    func formatButton(button: UIButton, title: String) {
        button.setTitle(title, for: UIControlState.normal)
        button.layer.backgroundColor = UIColor(red: 81/255, green: 149/255, blue: 243/255, alpha: 1).cgColor
        button.layer.cornerRadius = 15
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Format the title label
        myLabel.text = "Quadratic Bezier Curve with 21 Iterations"
        
        //Format the text view
        myTextView.layer.borderColor = UIColor.black.cgColor
        myTextView.layer.borderWidth = 2.0
        
        //Format the buttons
        formatButton(button: addSomething, title: "Add View")
        formatButton(button: DisplayButton, title: "Display Point T stats")
        formatButton(button: ClearButton, title: "Delete Point T stats")
        formatButton(button: ResetButton, title: "Reset View")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

