//
//  Utilitis.swift
//  testMath
//
//  Created by Sowrirajan S on 12/07/20.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit

open class ParentVc: UIViewController, SPControls {
    
    @objc public var payLoad: [String : Any]?
    
    public func send(payLoad: [String: Any]) {
        self.payLoad = payLoad
    }
    private var gradientLayer = CAGradientLayer()
    private var gradientApplied: Bool = false
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)


    public func goTo(_ source: UIViewController, storyBoard: StoryBoard, id: Identifiers, bundle: String? = nil,
                     transition: TransitionStyle = .push, animated: Bool = true,
                     style: UIModalPresentationStyle = .fullScreen,
                     payLoad: [String: Any]? = nil) {
        /* HINT: logic of fetching top view controller
        let _ = navigationController!.getViewController */
        let vc = setViewController(id: id, name: storyBoard)
        print(vc)
        vc?.payLoad = payLoad
        
        switch transition {
        case .present:
            let navigationController = UINavigationController(rootViewController: vc as! UIViewController)
            navigationController.modalPresentationStyle = style
            self.navigationController?.present(navigationController, animated: animated, completion: nil)
            
        case .push:
            guard let vc = vc else { fatalError("Destination viewcontroller not confirm to SPProtocols or Didn't inherit from ParentVc") }
            self.navigationController?.pushViewController(vc as! UIViewController, animated: animated)
            
        case .child:
            var containerView: UIView?
            if let payLoad = payLoad, let childView = payLoad["ChildView"] as? UIView {
                containerView = childView
            }
            guard let viewController = vc else {
                print("Destination viewcontroller not confirm to SPProtocols or Didn't inherit from ParentVc")
                return
            }
            addasChildView(source: source, destination: viewController as! UIViewController, container: containerView)
        }
    }
    
    public func goToPresent(_ source: UIViewController, storyBoard: StoryBoard, id: Identifiers, bundle: String? = nil,
                     transition: TransitionStyle = .present, animated: Bool = true,
                     style: UIModalPresentationStyle = .fullScreen,
                     payLoad: [String: Any]? = nil) {
        /* HINT: logic of fetching top view controller
        let _ = navigationController!.getViewController */
        let vc = setViewController(id: id, name: storyBoard)
        print(vc)
        vc?.payLoad = payLoad
        
        switch transition {
        case .present:
            
            let storyBoard: UIStoryboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: id.rawValue)
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC , animated: false, completion: nil)
            
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let nextVC = storyBoard.instantiateViewController(withIdentifier: "RegisterMainVC") as! RegisterMainVC
    //        self.present(vc as! UIViewController , animated: false, completion: nil)
            
//            let navigationController = UINavigationController(rootViewController: vc as! UIViewController)
//            navigationController.modalPresentationStyle = style
//            self.navigationController?.present(navigationController, animated: animated, completion: nil)
            
        case .push:
            guard let vc = vc else { fatalError("Destination viewcontroller not confirm to SPProtocols or Didn't inherit from ParentVc") }
            self.navigationController?.pushViewController(vc as! UIViewController, animated: animated)
            
        case .child:
            var containerView: UIView?
            if let payLoad = payLoad, let childView = payLoad["ChildView"] as? UIView {
                containerView = childView
            }
            guard let viewController = vc else {
                print("Destination viewcontroller not confirm to SPProtocols or Didn't inherit from ParentVc")
                return
            }
            addasChildView(source: source, destination: viewController as! UIViewController, container: containerView)
        }
    }
    
    func popToBack() {
        popTo()
    }
    
    func dissmiss() {
        dismiss(animated: false, completion: nil)
    }
//    func showLoadingHub() {
//        let loadingView = RSLoadingView()
//        loadingView.show(on: view)
//      }
    
    func showOnViewTwins() {
       // let loadingView = RSLoadingView(effectType: RSLoadingView.Effect.twins)
       // loadingView.show(on: view)
//        let loadingView = RSLoadingView()
//            loadingView.show(on: view)
        activityIndicator.center = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2)
               activityIndicator.color = UIColor.black
               view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
      }

    func hideLoadingHub() {
       // RSLoadingView.hide(from: view)
        activityIndicator.stopAnimating()
      }
    
    func popTo(_ viewController: AnyClass? = nil, _ type: popType = .back, _ animated: Bool? = true) {
        switch type {
        case .back:
            self.navigationController?.popViewController(animated: animated!)
        case .root:
            self.navigationController?.popToRootViewController(animated: animated!)
        case .to:
            let controller = (self.navigationController?.getViewController(of: viewController as! UIViewController.Type))!
            navigationController?.popToViewController(controller, animated: animated!)
        }
    }
    
    public func alert(_ title: AlertTitle,
               _ message: AlertMessage) {
        DispatchQueue.main.async {
            self.openAlert(title: title.rawValue,
                      message: message.rawValue,
                      alertStyle: .alert,
                      actionTitles: ["Ok"],
                      actionStyles: [.default],
                      actions: [{ _ in}])
        }
    }
    
    public func alert(_ title: AlertTitle,
               _ message: String) {
        DispatchQueue.main.async {
            self.openAlert(title: title.rawValue,
                      message: message,
                      alertStyle: .alert,
                      actionTitles: ["Ok"],
                      actionStyles: [.default],
                      actions: [{ _ in}])
        }
    }
    
    func openAlert(title: String,
                   message: String,
                   alertStyle:UIAlertController.Style,
                   actionTitles:[String],
                   actionStyles:[UIAlertAction.Style],
                   actions: [((UIAlertAction) -> Void)]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
    
    // Top showdow Layer
    func setTopShadowLayer(_ forView : UIView){
        forView.layer.backgroundColor = UIColor.clear.cgColor
        forView.layer.shadowOpacity = 0.2
        forView.layer.shadowOffset = CGSize(width: 0, height: -5)
        forView.layer.shadowRadius = 7
        forView.layer.shadowColor = UIColor.black.cgColor
        forView.layer.masksToBounds = false
    }
    // Bottom ShadowLayer
    func setBottomShadowLayer(_ forView : UIView){
        forView.layer.backgroundColor = UIColor.clear.cgColor
        forView.layer.shadowOpacity = 0.2
        forView.layer.shadowOffset = CGSize(width: 0, height: 2)
        forView.layer.shadowRadius = 7
        forView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.16).cgColor
        forView.layer.masksToBounds = false
    }
    
    //Add Imageview in Textfield//
    func addImageInTextFieldRight(textfield : UITextField , imageName : String){
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: textfield.frame.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: rightView.frame.width, height: rightView .frame.height))
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .center
        rightView.addSubview(imageView)
        textfield.rightView = rightView
        textfield.rightViewMode = .always
    }
    
    //Add Image in LeftSide//
    func addImageInTextFieldLeft(textfield : UITextField , imageName : String){
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: textfield.frame.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: leftView.frame.width, height: leftView.frame.height))
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .center
        leftView.addSubview(imageView)
        textfield.leftView = leftView
        textfield.leftViewMode = .always
    }
    
    
    //Add Image on Both sides//
    func addImageBothSides(textfield : UITextField , image1 : String , image2 : String){
        //Image on Right Side//
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: textfield.frame.height))
        let imageViewRight = UIImageView(frame: CGRect(x: 0, y: 0, width: rightView.frame.width, height: rightView.frame.height))
        imageViewRight.image = UIImage(named: image1)
        imageViewRight.contentMode = .center
        rightView.addSubview(imageViewRight)
        textfield.rightView = rightView
        textfield.rightViewMode = .always
        //Image on Left Side//
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: textfield.frame.height))
        let imageViewLeft = UIImageView(frame: CGRect(x: 0, y: 0, width: leftView.frame.width, height: leftView.frame.height))
        imageViewLeft.image = UIImage(named: image2)
        imageViewLeft.contentMode = .center
        leftView.addSubview(imageViewLeft)
        textfield.leftView = leftView
        textfield.leftViewMode = .always
    }
    // App gradient effect
    func applyGradientLayer() {
        if gradientLayer.superlayer != nil {
            gradientLayer.removeFromSuperlayer()
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 0.33, green: 0.43, blue: 0.90, alpha: 1.00).cgColor,
                                UIColor(red: 0.34, green: 0.29, blue: 0.56, alpha: 1.00).cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

class StoryBoards: UIStoryboard {
    func setStoryboard(_ name: String) -> UIStoryboard? {
        return type(of: self).init(name: name, bundle: nil)
    }
}

extension UIViewController {
    func setViewController(id: Identifiers,
                           name: StoryBoard) -> SPControls? {
        let storyBoard = StoryBoards().setStoryboard(name.rawValue)
        guard let vc = storyBoard?.instantiateViewController(withIdentifier: id.rawValue ) as? SPControls else {
            return nil
        }
        debugPrint("View controller not available")
        return vc
    }
    
    public func addasChildView(source: UIViewController,
                               destination: UIViewController,
                               container: UIView? = nil) {
        source.addChild(destination)
        var parent = source.view
        if let container = container {
            parent = container
        }
        parent?.addSubview(destination.view)
        if let bounds = parent?.bounds {
            destination.view.frame = CGRect(x: bounds.origin.x,
                                            y: bounds.origin.y,
                                            width: bounds.size.width,
                                            height: bounds.size.height)
        }
        destination.didMove(toParent: source)
        source.view.bringSubviewToFront(destination.view)
    }

    func makeBottomCurveView(view: UIView) {
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func setCollapsed(_ imageView: UIImageView, _ collapsed: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            if (collapsed) {
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
            } else {
                imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 270)
            }
        })
    }
    // Remove back button title
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    func dateFormatChange(date:String)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMM yyyy"
        return  dateFormatter.string(from: date!)
    }

}

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

public var isIpad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

extension UIView {
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.00).cgColor
    }
}
extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }

    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
