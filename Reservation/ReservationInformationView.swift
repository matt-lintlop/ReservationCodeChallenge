//
//  ReservationInformationView.swift
//  Reservation
//
//  Created by Matthew Lintlop on 11/15/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

import UIKit

class ReservationInformationView: UIView {

    // draw a light gray frame around the view
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext();
        context?.setStrokeColor(UIColor.lightGray.cgColor)
        context?.stroke(self.bounds)
   }
}
