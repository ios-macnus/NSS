//
//  CActivitiesVC.swift
//  NSS
//
//  Created by Gowma on 15/03/21.
//

import UIKit
import SJSegmentedScrollView

class CActivitiesVC: SJSegmentedViewController {
    
    var selectedSegment: SJSegmentTab?
    
    override func viewDidLoad() {
        if let storyboard = self.storyboard {

            let headerController = storyboard
                .instantiateViewController(withIdentifier: "HeaderViewControllerCActivities")

            let firstViewController = storyboard
                .instantiateViewController(withIdentifier: "CCurrentActivitiesVC")
            firstViewController.title = "Current"

            let secondViewController = storyboard
                .instantiateViewController(withIdentifier: "CPastActivitiesVC")
            secondViewController.title = "Past"
            
            let thirdViewController = storyboard
                .instantiateViewController(withIdentifier: "CFavActivitiesVC")
            thirdViewController.title = "Favourites"
            

            headerViewController = headerController
            segmentControllers = [firstViewController,
                                       secondViewController,thirdViewController]
            headerViewHeight = 40
            selectedSegmentViewHeight = 4.0
            headerViewOffsetHeight = 40.0
            segmentTitleColor = .gray
            segmentTitleFont = UIFont.systemFont(ofSize: 17.0)
            selectedSegmentViewColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.00)
            segmentShadow = SJShadow.light()
            showsHorizontalScrollIndicator = false
            showsVerticalScrollIndicator = false
            segmentBounces = false
            delegate = self
        }

        //title = "Segment"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func getSegmentTabWithImage(_ imageName: String) -> UIView {

        let view = UIImageView()
        view.frame.size.width = 100
        view.image = UIImage(named: imageName)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        return view
    }

}

extension CActivitiesVC: SJSegmentedViewControllerDelegate {

    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {

        if selectedSegment != nil {
            selectedSegment?.titleColor(.lightGray)
        }

        if segments.count > 0 {

            selectedSegment = segments[index]
            selectedSegment?.titleColor(.red)
        }
    }
}
