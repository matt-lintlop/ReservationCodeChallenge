//
//  ScheduleViewController.swift
//  Reservation
//
//  Created by Matthew Lintlop on 11/12/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var reserveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        reserveButton.backgroundColor = UIColor.clear
        
        let image = UIImage(named: "Images/Button.png")
        reserveButton.setBackgroundImage(image, for: .normal)
        reserveButton.setBackgroundImage(UIImage(named: "Images/Button.png"), for: .disabled)
        reserveButton.setImage(UIImage(named: "Images/ButtonHighlighted.png"), for: .highlighted)
        reserveButton.setNeedsDisplay()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func reservePressed(_ sender: Any) {
        print("Reserve Button Pressed")
    }
}

