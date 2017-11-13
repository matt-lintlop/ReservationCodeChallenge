//
//  MassageServiceBackgroundView.swift
//  Reservation
//
//  Created by Matthew Lintlop on 11/11/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

import UIKit
import Foundation
import QuartzCore

@objc protocol ServiceBackgroundPageViewDelegate {
    func didShowBackgroundForPageNumber(_ number: Int);
}
class ServiceBackgroundPageView: UIView {

    var image: UIImage?
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!
    var scrollImageTimer: Timer?
    var isScrolling = false
    var lastDrawTime: TimeInterval!
    var scrollStartTime: TimeInterval!
    weak var delegate: ServiceBackgroundPageViewDelegate?
    
    let scrollSpeedInPointsPerSecond = 100.0
    
    required init?(coder aDecoder: NSCoder) {
        lastDrawTime = Date.timeIntervalSinceReferenceDate
        scrollStartTime = Date.timeIntervalSinceReferenceDate

        super.init(coder: aDecoder)

        let frame = self.frame
        let imageWidth: CGFloat = self.bounds.size.width
        
        for i in 0...2 {
            var currentImageViewFrame = frame
            currentImageViewFrame.origin.x += (CGFloat(i) * imageWidth)

            switch i {
            case 0:
                imageView1 = UIImageView(image: UIImage(named: "Images/SpaServiceImage1.png")!)
                imageView1.frame = currentImageViewFrame
                self.addSubview(imageView1)
                
           case 1:
                imageView2 = UIImageView(image: UIImage(named: "Images/SpaServiceImage2.png")!)
                imageView2.frame = currentImageViewFrame
                self.addSubview(imageView2)
                
            case 2:
                imageView3 = UIImageView(image: UIImage(named: "Images/SpaServiceImage3.png")!)
                imageView3.frame = currentImageViewFrame
                self.addSubview(imageView3)
                
            default:
                break;
            }
            
        }
        
        perform(#selector(startScrolling(sender:)), with: self, afterDelay: 2.5)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let frame = self.frame
        let imageWidth: CGFloat = self.bounds.size.width
        
        for i in 0...2 {
            var currentImageViewFrame = frame
            currentImageViewFrame.origin.x += (CGFloat(i) * imageWidth)
            
            switch i {
            case 0:
                imageView1.frame = currentImageViewFrame
                
            case 1:
                imageView2.frame = currentImageViewFrame
                
            case 2:
                imageView3.frame = currentImageViewFrame
                
            default:
                break;
            }
        }
    }
    
    @objc func timerFireMethod(timer: Timer) {
        if Thread.current.isMainThread {
            self.scrollImages()
        }
        else {
            DispatchQueue.main.async { [unowned self] in
                self.scrollImages()
            }
        }
    }

    @objc func startScrolling(sender: Any) {
        if !isScrolling {
            lastDrawTime = Date.timeIntervalSinceReferenceDate
            scrollImageTimer = Timer(timeInterval: Double(Double(1)/Double(60)), target: self, selector: #selector(timerFireMethod(timer:)), userInfo: nil, repeats: true)
            RunLoop.current.add(scrollImageTimer!, forMode: .defaultRunLoopMode)
            scrollImageTimer?.fire()
            scrollStartTime = Date.timeIntervalSinceReferenceDate
            isScrolling = true
        }
    }
    
    @objc func stopScrolling() {
        if isScrolling {
            scrollImageTimer?.invalidate()
            isScrolling = false
        }
    }

    func scrollImages() {
        
        // Save inital visiblity state of the sub-viewa
        let page1WasVisible = isSubViewVisible(self.imageView1)
        let page2WasVisible = isSubViewVisible(self.imageView2)
        let page3WasVisible = isSubViewVisible(self.imageView3)

        // compute the elapsed time in seconds since the last time the images were scrolled.
        let currentTime = Date.timeIntervalSinceReferenceDate
        let elapsedTime = currentTime - lastDrawTime
        lastDrawTime = currentTime
        
        // compute the distance on points to translate the images
        let distance = CGFloat(scrollSpeedInPointsPerSecond) * CGFloat(elapsedTime) * CGFloat(-1)

        // scroll the images left with implicit animations disabled
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)

        imageView1.frame = imageView1.frame.offsetBy(dx: distance, dy: 0)
        imageView2.frame = imageView2.frame.offsetBy(dx: distance, dy: 0)
        imageView3.frame = imageView3.frame.offsetBy(dx: distance, dy: 0)
        
        // handle moving images that have disappeared from the screen left edge.
        if imageView1.frame.maxX < 0 {
            imageView1.frame = imageView1.frame.offsetBy(dx: UIScreen.main.bounds.size.width * 3, dy: 0)
        }
        if imageView2.frame.maxX < 0 {
            imageView2.frame = imageView2.frame.offsetBy(dx: UIScreen.main.bounds.size.width * 3, dy: 0)
        }
        if imageView3.frame.maxX < 0 {
            imageView3.frame = imageView3.frame.offsetBy(dx: UIScreen.main.bounds.size.width * 3, dy: 0)
        }

        CATransaction.commit()
 
        // Get new visiblity state of the sub-viewa
        let page1NowVisible = isSubViewVisible(self.imageView1)
        let page2NowVisible = isSubViewVisible(self.imageView2)
        let page3NowVisible = isSubViewVisible(self.imageView3)
        
        // Handle calling delegate when a new page is shown.
        if page1WasVisible && !page1NowVisible {
            delegate?.didShowBackgroundForPageNumber(1)
        }
        else if page2WasVisible && !page2NowVisible {
            delegate?.didShowBackgroundForPageNumber(2)
        }
        else if page3WasVisible && !page3NowVisible {
            delegate?.didShowBackgroundForPageNumber(0)
        }
}
 
    func showBackgroungForPageNumber(_ pageNumber: Int) {
        
        stopScrolling()
        
        let frame = self.frame
        let screenWidth: CGFloat = self.bounds.size.width

        // Show the specified page # and place the other pages to the right.
        switch pageNumber {
    
        case 0:
            imageView1.frame = frame
            imageView2.frame.origin.x = screenWidth
            imageView3.frame.origin.x = screenWidth * 2

        case 1:
            imageView2.frame = frame
            imageView3.frame.origin.x = screenWidth
            imageView1.frame.origin.x = screenWidth * 2

        case 2:
            imageView3.frame = frame
            imageView1.frame.origin.x = screenWidth
            imageView2.frame.origin.x = screenWidth * 2

        default:
            break;
        }
        
        // notify the delegate about the new current page.
        delegate?.didShowBackgroundForPageNumber(pageNumber)
        
        perform(#selector(startScrolling(sender:)), with: self, afterDelay: 2.5)
    }

    // MARK: Utility
    
    // Determine if a Sub-View is at all visible on the screen.
    private func isSubViewVisible(_ subView: UIView) -> Bool {
        return subView.frame.intersects(self.frame)
    }
}
