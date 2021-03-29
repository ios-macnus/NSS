//
//  ClientApplicationMainVC.swift
//  NSS
//
//  Created by Gowma on 21/03/21.
//

import UIKit

class ClientApplicationMainVC: ParentVc {

    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var segmentContainerView3: UIView!
    @IBOutlet weak var segmentContainerView2: UIView!
    @IBOutlet weak var segmentContainerView1: UIView!
    @IBOutlet weak var viewSegmentBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblJobDate: UILabel!
    @IBOutlet weak var lblPostDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    var buttonBar = UIView()
    var strJobTitleB = ""
    var strJobInfo1 = ""
    var strJobDate = ""
    var strJobPost = ""
    var strPrice = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: strJobDate)
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date2 = dateFormatter2.date(from: strJobPost)
        dateFormatter2.dateFormat = "dd MMM yyyy"
        
        lblTitle.text = strJobTitleB
        lblInfo.text = strJobInfo1
        lblJobDate.text = "\(dateFormatter.string(from: date!))"
        lblPostDate.text = "\(dateFormatter2.string(from: date2!))"
        lblPrice.text = "$ " + strPrice
        
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

    @IBAction func btnBack(_ sender: Any) {
        dissmiss()
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
