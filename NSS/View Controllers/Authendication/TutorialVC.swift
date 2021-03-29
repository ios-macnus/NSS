//
//  TutorialVC.swift
//  NSS
//
//  Created by Gowma on 24/01/21.
//

import UIKit

class TutorialVC: ParentVc {

    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var viewNext: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imgSlider: UIImageView!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    private var currentPage = 1
    private var fillImage: UIImage = UIImage.init(named: "Ellipse_fill")!
    private var unfillImage: UIImage = UIImage.init(named: "Ellipse_unfill")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewSlider1()
        viewNext.layer.backgroundColor = UIColor.white.cgColor
        viewNext.layer.borderWidth = 1
        viewNext.layer.borderColor = UIColor.black.cgColor
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToNextItem(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(moveToNextItem(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func moveToNextItem(_ sender:UISwipeGestureRecognizer) {

       switch sender.direction{
       case .left:
        self.moveFetch()
        break
       case .right:
        self.moveFetchRight()
        break
       default: break
        }
    }

    func moveFetch() {
        if currentPage == 1 {
            viewSlider2()
        } else if currentPage == 2 {
            viewSlider3()
        } else {
        }
    }
    
    func moveFetchRight() {
        if currentPage == 3 {
            viewSlider2()
        } else if currentPage == 2 {
            viewSlider1()
        } else {
        }
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if currentPage == 1 {
            viewSlider2()
        } else if currentPage == 2 {
            viewSlider3()
        } else {
            self.goToPresent(self, storyBoard: .main, id: .registerMainVC)
        }
    }
    
    func viewSlider1() {
        currentPage = 1
        lblWelcome.text = "Welcome! "
        btnNext.setTitle("Next", for: .normal)
        btnNext.setTitleColor(.black, for: .normal)
        viewNext.layer.backgroundColor = UIColor.white.cgColor
        imgSlider.image = UIImage.init(named: "slider1")
        img1.image = fillImage
        img2.image = unfillImage
        img3.image = unfillImage
        lblDesc.text = "Post jobs or find jobs based on Location"
        imgAnimation()
    }
    
    func viewSlider2() {
        currentPage = 2
        lblWelcome.text = "Welcome! "
        btnNext.setTitle("Next", for: .normal)
        btnNext.setTitleColor(.black, for: .normal)
        viewNext.layer.backgroundColor = UIColor.white.cgColor
        imgSlider.image = UIImage.init(named: "slider2")
        lblDesc.text = "Over 1000 Jobs posted and 1000 Skilled Professionals"
        img1.image = unfillImage
        img2.image = fillImage
        img3.image = unfillImage
        imgAnimation()
    }
    
    func viewSlider3() {
        currentPage = 3
        lblWelcome.text = "Welcome! "
        btnNext.setTitle("Get Started", for: .normal)
        btnNext.setTitleColor(.white, for: .normal)
        viewNext.layer.backgroundColor = UIColor.black.cgColor
        imgSlider.image = UIImage.init(named: "slider3")
        lblDesc.text = "Enjoy secure transactions through NSS"
        img1.image = unfillImage
        img2.image = unfillImage
        img3.image = fillImage
        imgAnimation()
    }
    
    func imgAnimation() {
        UIView.animate(withDuration: 0.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.imgSlider.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
         }) { (finished) in
            UIView.animate(withDuration: 0.8, animations: {
              self.imgSlider.transform = CGAffineTransform.identity // undo in 1 seconds
           })
        }
    }
}
