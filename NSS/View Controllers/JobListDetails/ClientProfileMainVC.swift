//
//  ClientProfileMainVC.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import UIKit

class ClientProfileMainVC: ParentVc {
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var segmentContainerView3: UIView!
    @IBOutlet weak var segmentContainerView2: UIView!
    @IBOutlet weak var segmentContainerView1: UIView!
    @IBOutlet weak var viewSegmentBg: UIView!
    var buttonBar = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentContainerView1.alpha = 1.0
        segmentContainerView2.alpha = 0.0
        segmentContainerView3.alpha = 0.0
        
        // Add lines below the segmented control's tintColor
        segmentController.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Avenir-Book", size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ], for: .normal)
        
        segmentController.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Avenir-Book", size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: .selected)
        segmentController.backgroundColor = .white
        segmentController.tintColor = .clear
        segmentController.layer.backgroundColor = UIColor.white.cgColor
        segmentController.removeBorders()
        
        // This needs to be false since we are using auto layout constraints
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor.orange
        
        viewSegmentBg.addSubview(buttonBar)
        
        // Constrain the top of the button bar to the bottom of the segmented control
        buttonBar.topAnchor.constraint(equalTo: segmentController.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentController.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentController.widthAnchor, multiplier: 1 / CGFloat(segmentController.numberOfSegments)).isActive = true
        
        
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentController.frame.width / CGFloat(self.segmentController.numberOfSegments)) * CGFloat(self.segmentController.selectedSegmentIndex)
        }
    }
    
    @IBAction func didChangeIndex(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            segmentContainerView1.alpha = 1.0
            segmentContainerView2.alpha = 0.0
            segmentContainerView3.alpha = 0.0
        case 1:
            segmentContainerView1.alpha = 0.0
            segmentContainerView2.alpha = 1.0
            segmentContainerView3.alpha = 0.0
        case 2:
            segmentContainerView1.alpha = 0.0
            segmentContainerView2.alpha = 0.0
            segmentContainerView3.alpha = 1.0
        default:
            break
        }
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentController.frame.width / CGFloat(self.segmentController.numberOfSegments)) * CGFloat(self.segmentController.selectedSegmentIndex)
        }
    }
    
}
