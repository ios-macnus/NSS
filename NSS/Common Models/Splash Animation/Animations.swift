//
//  Animations.swift
//  Giftry_Clone
//
//  Created by Ragul'S MAC Mini on 16/01/17.
//  Copyright © 2017 Ragul'S MAC Mini. All rights reserved.
//

import Foundation
import UIKit


public typealias SplashAnimatableCompletion = () -> Void
public typealias SplashAnimatableExecution = () -> Void

// MARK: - Protool extension to define the basic functionality for the SplashAnimatable
public extension SplashAnimatable where Self: UIView {
    
    /**
     Starts the animation depending on the type
     */
    func startAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        switch animationType{
        case .Twitter:
            playTwitterAnimation(completion)
            
        case .RotateOut:
            playRotateOutAnimation(completion)
            
        case .WoobleAndZoomOut:
            playWoobleAnimation(completion)
            
        case .SwingAndZoomOut:
            playSwingAnimation(completion)
            
        case.PopAndZoomOut:
            playPopAnimation(completion)
            
        case.SqueezeAndZoomOut:
            playSqueezeAnimation(completion)
        }
        
    }
    
    
    /**
     Plays the twitter animation
     */
    func playTwitterAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        
        if let imageView = self.imageView {
            
            //Define the shink and grow duration based on the duration parameter
            let shrinkDuration: TimeInterval = duration * 0.3
            
            //Plays the shrink animation
            UIView.animate(withDuration: shrinkDuration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIView.AnimationOptions(), animations: {
                //Shrinks the image
                let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.75,y: 0.75)
                imageView.transform = scaleTransform
                
                //When animation completes, grow the image
            }, completion: { finished in
                
                self.playZoomOutAnimation(completion)
            })
        }
    }
    
    
    /**
     Plays the twitter animation
     */
    func playSqueezeAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        
        if let imageView = self.imageView {
            
            //Define the shink and grow duration based on the duration parameter
            let shrinkDuration: TimeInterval = duration * 0.5
            
            //Plays the shrink animation
            UIView.animate(withDuration: shrinkDuration, delay: delay/3, usingSpringWithDamping: 10, initialSpringVelocity: 10, options: UIView.AnimationOptions(), animations: {
                //Shrinks the image
                let scaleTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.30,y: 0.30)
                imageView.transform = scaleTransform
                
                //When animation completes, grow the image
            }, completion: { finished in
                
                self.playZoomOutAnimation(completion)
            })
        }
    }
    
    /**
     Plays the rotate out animation
     
     - parameter completion: when the animation completes
     */
    func playRotateOutAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        if let imageView = self.imageView{
            
            /**
             Sets the animation with duration delay and completion
             
             - returns:
             */
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: UIView.AnimationOptions(), animations: {
                
                //Sets a simple rotate
                let rotateTranform = CGAffineTransform(rotationAngle: CGFloat(M_PI * 0.99))
                //Mix the rotation with the zoom out animation
                imageView.transform = rotateTranform.concatenating(self.getZoomOutTranform())
                //Removes the animation
                self.alpha = 0
                
            }, completion: { finished in
                
                self.removeFromSuperview()
                
                completion?()
            })
            
        }
    }
    
    /**
     Plays a wobble animtion and then zoom out
     
     - parameter completion: completion
     */
    func playWoobleAnimation(_ completion: SplashAnimatableCompletion? = nil) {
        
        if let imageView = self.imageView{
            
            let woobleForce = 0.5
            
            animateLayer({
                let rotation = CAKeyframeAnimation(keyPath: "transform.rotation")
                rotation.values = [0, 0.3 * woobleForce, -0.3 * woobleForce, 0.3 * woobleForce, 0]
                rotation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                rotation.isAdditive = true
                
                let positionX = CAKeyframeAnimation(keyPath: "position.x")
                positionX.values = [0, 30 * woobleForce, -30 * woobleForce, 30 * woobleForce, 0]
                positionX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                positionX.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                positionX.isAdditive = true
                
                let animationGroup = CAAnimationGroup()
                animationGroup.animations = [rotation, positionX]
                animationGroup.duration = CFTimeInterval(self.duration/2)
                animationGroup.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay/2)
                animationGroup.repeatCount = 2
                imageView.layer.add(animationGroup, forKey: "wobble")
            }, completion: {
                
                self.playZoomOutAnimation(completion)
            })
            
        }
    }
    
    /**
     Plays the swing animation and zoom out
     
     - parameter completion: completion
     */
    func playSwingAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        if let imageView = self.imageView{
            
            let swingForce = 0.8
            
            animateLayer({
                
                let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
                animation.values = [0, 0.3 * swingForce, -0.3 * swingForce, 0.3 * swingForce, 0]
                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                animation.duration = CFTimeInterval(self.duration/2)
                animation.isAdditive = true
                animation.repeatCount = 2
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay/3)
                imageView.layer.add(animation, forKey: "swing")
                
            }, completion: {
                self.playZoomOutAnimation(completion)
            })
        }
    }
    
    
    /**
     Plays the pop animation with completion
     
     - parameter completion: completion
     */
    func playPopAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        if let imageView = self.imageView{
            
            let popForce = 0.5
            
            animateLayer({
                let animation = CAKeyframeAnimation(keyPath: "transform.scale")
                animation.values = [0, 0.2 * popForce, -0.2 * popForce, 0.2 * popForce, 0]
                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                animation.duration = CFTimeInterval(self.duration/2)
                animation.isAdditive = true
                animation.repeatCount = 2
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(self.delay/2)
                imageView.layer.add(animation, forKey: "pop")
            }, completion: {
                self.playZoomOutAnimation(completion)
            })
        }
    }
    
    /**
     Plays the zoom out animation with completion
     
     - parameter completion: completion
     */
    func playZoomOutAnimation(_ completion: SplashAnimatableCompletion? = nil)
    {
        if let imageView =  imageView
        {
            let growDuration: TimeInterval =  duration * 0.3
            
            UIView.animate(withDuration: growDuration, animations:{
                
                imageView.transform = self.getZoomOutTranform()
                self.alpha = 0
                
                //When animation completes remote self from super view
            }, completion: { finished in
                
                self.removeFromSuperview()
                
                completion?()
            })
        }
    }
    
    
    
    /**
     Retuns the default zoom out transform to be use mixed with other transform
     
     - returns: ZoomOut fransfork
     */
    fileprivate func getZoomOutTranform() -> CGAffineTransform
    {
        let zoomOutTranform: CGAffineTransform = CGAffineTransform(scaleX: 20, y: 20)
        return zoomOutTranform
    }
    
    
    // MARK: - Private
    fileprivate func animateLayer(_ animation: SplashAnimatableExecution, completion: SplashAnimatableCompletion? = nil) {
        
        CATransaction.begin()
        if let completion = completion {
            CATransaction.setCompletionBlock { completion() }
        }
        animation()
        CATransaction.commit()
    }
    
    
    
}
