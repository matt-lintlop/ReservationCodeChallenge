//
//  MyReservationsViewController.swift
//  Reservation
//
//  Created by Matthew Lintlop on 11/11/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

import UIKit
import Foundation

class MyReservationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the navigaition bar color = light blue and the navigation title color = white
        let lightBlue = UIColor(red: 102.0/255.0, green: 178.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.barTintColor = lightBlue
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

