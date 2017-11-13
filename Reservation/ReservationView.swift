//
//  ReservationView.swift
//  Reservation
//
//  Created by Matthew Lintlop on 11/12/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

import UIKit

class ReservationView: UIView {

//    weak var dateLabel: UILabel!
//    weak var serviveTypeLabel: UILabel!
//    weak var durationLabel: UILabel!
//    weak var descriptionLabel: UILabel!
 
    weak var dateLabel: UIView!
    weak var serviveTypeLabel: UIView!
    weak var durationLabel: UIView!
    weak var descriptionLabel: UIView!

    weak var rescheduleButtonBackground: UIView!
    weak var cancelButtonBackground: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        dateLabel = self.viewWithTag(1)! as! UILabel
//        serviveTypeLabel = self.viewWithTag(2)! as! UILabel
//        durationLabel = self.viewWithTag(3)! as! UILabel
//        descriptionLabel = self.viewWithTag(4)! as! UILabel

        dateLabel = self.viewWithTag(1)!
        serviveTypeLabel = self.viewWithTag(2)!
        durationLabel = self.viewWithTag(3)!
        descriptionLabel = self.viewWithTag(4)!

        rescheduleButtonBackground = self.viewWithTag(5)!
        rescheduleButtonBackground.layer.cornerRadius = 10

        cancelButtonBackground = self.viewWithTag(6)!
        cancelButtonBackground.layer.cornerRadius = 10
    }

}
