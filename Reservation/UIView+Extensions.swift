//
//  UIView+Extensions.swift
//  Reservation
//
//  Created by Matthew Lintlop on 11/12/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

import UIKit

extension UIView{
    
    // The extension method will make a copy of a view,
    // which is usefule for crating StackView with
    // container views
    func copyView() -> AnyObject{
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self))! as AnyObject
    }
}
