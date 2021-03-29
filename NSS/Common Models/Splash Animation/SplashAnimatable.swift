//
//  SplashAnimatable.swift
//  Giftry_Clone
//
//  Created by Ragul'S MAC Mini on 16/01/17.
//  Copyright © 2017 Ragul'S MAC Mini. All rights reserved.
//

import Foundation
import UIKit
/**
 *  Protocol that represents splash animatable functionality
 */
public protocol SplashAnimatable: class{
    
    /// The image view that shows the icon
    var imageView: UIImageView? { get set }
    
    /// The animation type
    var animationType: SplashAnimationType { get set }
    
    /// The duration of the overall animation
    var duration: Double { get set }
    
    /// The delay to play the animation
    var delay: Double { get set }
    
}

