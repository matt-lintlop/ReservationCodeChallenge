//
//  SpaServiceViewController.swift
//  Reservation
//
//  Created by Matthew Lintlop on 11/11/17.
//  Copyright © 2017 Matthew Lintlop. All rights reserved.
//

import UIKit

class SpaServiceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ServiceBackgroundPageViewDelegate {
    @IBOutlet weak var reserveButtonView: UIView!
    @IBOutlet weak var servicesTableview: UITableView!
    @IBOutlet weak var servicePageBackgroundView: ServiceBackgroundPageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var reserveButton: UIButton!
    
    let messageServiceNames: [String] = [MessageServiceType.swedishMessage.name,
                                         MessageServiceType.deepTissueMessage.name,
                                         MessageServiceType.hotStonyMessage.name,
                                         MessageServiceType.reflexology.name,
                                         MessageServiceType.triggerPointTherapy.name]

    override func viewDidLoad() {
        super.viewDidLoad()

        servicesTableview.delegate = self
        servicePageBackgroundView.delegate = self
        pageControl.addTarget(self, action: #selector(changePage(pageControl:)), for: UIControlEvents.touchUpInside)
        
        reserveButtonView.layer.cornerRadius = 10
        reserveButtonView.isHidden = false
        reserveButton.isEnabled = false
        reserveButton.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        servicePageBackgroundView.stopScrolling()
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        servicePageBackgroundView.startScrolling(sender:self)
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Page Control
    @objc func changePage(pageControl: UIPageControl) {
        servicePageBackgroundView.showBackgroungForPageNumber(pageControl.currentPage)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageServicesCell")!
        cell.textLabel?.text = messageServiceNames[indexPath.row]
        
        if let serviceName = MessageServiceType(rawValue: indexPath.row),
            serviceName == .hotStonyMessage {
            
            // Make the Hot Stone Massage cell selectable
            cell.selectionStyle = .default
        }
        else {
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(64)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let serviceName = MessageServiceType(rawValue: indexPath.row),
            serviceName == .hotStonyMessage {
            
            // Make the Hot Stone Massage cell selectable
            tableView.selectRow(at: indexPath, animated:true, scrollPosition: .none)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0 ? messageServiceNames.count : 0);
    }

    // MARK: - ServiceBackgroundPageViewDelegate
    
    // Handle delegate callback when a new page background image is shown.
    // Show the Reserve button only if the "Hot Stony Message" is the current page.
    func didShowBackgroundForPageNumber(_ number: Int) {        
        if number == 1 {
            reserveButton.isEnabled = true
            reserveButton.setTitleColor(UIColor.white, for: .normal)
       }
        else {
            reserveButton.isEnabled = false
            reserveButton.setTitleColor(UIColor.lightGray, for: .normal)
        }
        
        // set the current page indicator value.
        pageControl.currentPage = number
        
        servicePageBackgroundView.stopScrolling()
        servicePageBackgroundView.perform(#selector(servicePageBackgroundView.startScrolling(sender:)), with: self, afterDelay: 2.5)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
