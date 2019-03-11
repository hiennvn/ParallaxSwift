//
//  PVAnimation.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 1/28/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import UIKit

public class PVActionAnimated: PVAction {
    @IBInspectable public var duration : Double = 0.0
    @IBInspectable public var disappearPageIndex : Int?
    private var started = false
    
    final public override func start() {
        super.start()
        if !started {
            started = true
            appearAnimate()
        }
    }
    
    final func restart(){
        if started {
            started = false
            restartAnimate()
        }
    }
    
    final func end(){
        if started {
            started = false
            disappearAnimate()
        }
    }
    
    public func appearAnimate(){
        
    }
    
    public func restartAnimate(){
        
    }
    
    public func disappearAnimate(){
        
    }
    
    
    public override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "disappearPageIndex" {
            self.disappearPageIndex = value?.integerValue
        }
    }
}
