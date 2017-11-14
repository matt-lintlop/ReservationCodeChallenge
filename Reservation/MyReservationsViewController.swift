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

    @IBOutlet weak var reservationView: ReservationView!
    @IBOutlet weak var reservationsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set the navigaition bar color = light blue and the navigation title color = white
        let lightBlue = UIColor(red: 102.0/255.0, green: 178.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
        self.navigationController?.navigationBar.barTintColor = lightBlue
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false;
        
        makeReservationViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeReservationViews() {
        guard let allReservations = ReservationService.shared.reservations else {
            return
        }
        var reservationViews: [ReservationView] = []
        for reservation in allReservations {
            let reservationView = self.reservationView.copyView() as! ReservationView
            reservationView.setReservation(reservation)
            reservationViews.append(reservationView)
            reservationsStackView.addArrangedSubview(reservationView)
            
            let frame = reservationView.frame
            print("reservationView frame: /(frame)")
       }
    }
}

