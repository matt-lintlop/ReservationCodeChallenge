//
//  ReservationView.swift
//  Reservation
//
//  Created by Matthew Lintlop on 11/12/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

import UIKit

class ReservationView: UIView {

    weak var dateLabel: UILabel!
    weak var timeLabel: UILabel!
    weak var serviceTypeLabel: UILabel!
    weak var durationLabel: UILabel!
    weak var descriptionLabel: UILabel!

    weak var rescheduleButtonBackground: UIView!
    weak var cancelButtonBackground: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        // retrieve the sub-view items using the view's tag.
        dateLabel = self.viewWithTag(1)! as! UILabel
        timeLabel = self.viewWithTag(7)! as! UILabel
        serviceTypeLabel = self.viewWithTag(2)! as! UILabel
        durationLabel = self.viewWithTag(3)! as! UILabel
        descriptionLabel = self.viewWithTag(4)! as! UILabel
        
        rescheduleButtonBackground = self.viewWithTag(5)!
        rescheduleButtonBackground.layer.cornerRadius = 10
        
        cancelButtonBackground = self.viewWithTag(6)!
        cancelButtonBackground.layer.cornerRadius = 10
    }
    
    func setReservation(_ reservation: Reservation) {
        let reservationService = ReservationService.shared
        dateLabel.text = reservationService.getMonthAndDayString(from: reservation.date)
        timeLabel.text = reservationService.getTimeString(from: reservation.date)
        serviceTypeLabel.text = reservation.serviceType.name
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        // draw a black frame around the view
        let context = UIGraphicsGetCurrentContext();
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.stroke(self.bounds)
    }
}
