//
//  Splashview.swift
//  Giftry_Clone
//
//  Created by Ragul'S MAC Mini on 16/01/17.
//  Copyright © 2017 Ragul'S MAC Mini. All rights reserved.
//

import Foundation
import UIKit


/// SplashView that reveals its content and animate, like twitter
open class Splashview: UIView, SplashAnimatable{
    
    
    /// The icon image to show and reveal with
    open var iconImage: UIImage? {
        
        didSet{
            if let iconImage = self.iconImage{
                imageView?.image = iconImage
            }
        }
        
    }
    
    ///The icon color of the image, defaults to white
    open var iconColor: UIColor = UIColor.white{
        
        didSet{
            
            imageView?.tintColor = iconColor
        }
        
    }
    
    open var useCustomIconColor: Bool = false{
        
        didSet{
            
            if(useCustomIconColor == true){
                
                if let iconImage = self.iconImage {
                    imageView?.image = iconImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                }
            }
            else{
                
                if let iconImage = self.iconImage {
                    imageView?.image = iconImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
                }
            }
        }
    }
    
    ///The initial size of the icon. Ideally it has to match with the size of the icon in your LaunchScreen Splash view
    open var iconInitialSize: CGSize = CGSize(width: 60, height: 60) {
        
        didSet{
            
            imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        }
    }
    
    /// THe image view containing the icon Image
    open var imageView: UIImageView?
    
    /// The type of animation to use for the. Defaults to the Twitter default animation
    open var animationType: SplashAnimationType = SplashAnimationType.Twitter
    
    /// The duration of the animation, default to 1.5 seconds
    open var duration: Double = 1.5
    
    /// The delay of the animation, default to 0.5 seconds
    open var delay: Double = 0.5
    
    /**
     Default constructor of the class
     
     - parameter iconImage:       The Icon image to show the animation
     - parameter iconInitialSize: The initial size of the icon image
     - parameter backgroundColor: The background color of the image, ideally this should match your Splash view
     
     - returns: The created RevealingSplashViewObject
     */
    public init(iconImage: UIImage, iconInitialSize:CGSize, backgroundColor: UIColor)
    {
        //Sets the initial values of the image view and icon view
        self.imageView = UIImageView()
        self.iconImage = iconImage
        self.iconInitialSize = iconInitialSize
        //Inits the view to the size of the screen
        super.init(frame: UIScreen.main.bounds)
        
        imageView?.image = iconImage
        imageView?.tintColor = iconColor
        //Set the initial size and position
        imageView?.frame = CGRect(x: 0, y: 0, width: iconInitialSize.width, height: iconInitialSize.height)
        //Sets the content mode and set it to be centered
        imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        imageView?.center = self.center
        
        //Adds the icon to the view
        self.addSubview(imageView!)
        
        //Sets the background color
        self.backgroundColor = backgroundColor
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

