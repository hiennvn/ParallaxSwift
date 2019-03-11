//
//  PVTransition.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 1/28/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import UIKit

class PVTransition: NSObject {
    var interactiveActions = [PVActionInteractive]()
    var appearAnimatedActions = [PVActionAnimated]()
    var disappearAnimatedActions = [PVActionAnimated]()
    
    
    var onStable : Bool = false
    
    
    func runRestartActions() {
        if onStable{
            onStable = false
            appearAnimatedActions.forEach({$0.restart()})
        }
    }
    
    func runDisappearActions() {
        if onStable {
            onStable = false
            disappearAnimatedActions.forEach({$0.end()})
        }
    }
    
    func start(){
        if !onStable {
            onStable = true
            appearAnimatedActions.forEach({ (anAction) in
                anAction.start()
            })
        }
        
        interactiveActions.forEach { (anAction) -> () in
            if anAction.forwarding {
                anAction.start()
            } else {
                anAction.update(1.0)
            }
        }
    }
    
    func end(){
        interactiveActions.forEach { (anAction) -> () in
            if anAction.forwarding {
                anAction.update(1.0)
            } else {
                anAction.start()
            }
        }
    }
    
    func update(progress: CGFloat, forwarding: Bool) {
        interactiveActions.forEach { (anAction) -> () in
            if anAction.forwarding == forwarding || anAction.autoReverse {
                anAction.update(anAction.forwarding ? progress : 1 - progress)
            }
        }
    }
    
}
