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
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // set the reserver button custom background images.
        reserveButton.setBackgroundImage(UIImage(named: "Images/Button.png"), for: .normal)
        reserveButton.setBackgroundImage(UIImage(named: "Images/ButtonHighlighted.png"), for: .highlighted)
        reserveButton.setNeedsDisplay()
        
        serviceImageView.image = UIImage(named: "Images/SmallHotStoneMassage.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func reservePressed(_ sender: Any) {
        print("Reserve Button Pressed")
    }
}

