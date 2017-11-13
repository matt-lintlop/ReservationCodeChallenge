//
//  LaunchScreenViewController.swift
//  Reservation
//
//  Created by Matthew Lintlop on 11/11/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

import UIKit
import Foundation

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the navigaition bar color = blue and the navigation title color = white
        self.navigationController?.navigationBar.barTintColor = UIColor.blue
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

