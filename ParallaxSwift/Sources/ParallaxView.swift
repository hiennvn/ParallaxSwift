//
//  ParallaxView.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 10/27/15.
//  Copyright © 2015 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol ParallaxViewDelegate {

}

@objc public protocol ParallaxViewDataSource {
    func interactiveActionsForParallaxView(view: ParallaxView) -> [PVActionInteractive]
    func animatedActionsForParallaxView(view: ParallaxView) -> [PVActionAnimated]
}

public class ParallaxView : UIView, UIScrollViewDelegate {
    @IBInspectable public private(set) var scrollHorizontal : Bool = true
    @IBInspectable public private(set) var pageCount : Int = 0
    @IBOutlet public var interactiveActions : [PVActionInteractive] = [PVActionInteractive]()
    @IBOutlet public var animatedActions : [PVActionAnimated] = [PVActionAnimated]()
    
    @IBOutlet public weak var delegate : ParallaxViewDelegate?
    @IBOutlet public weak var dataSource: ParallaxViewDataSource?
    
    
    
    //private properties
    private var _transitions = [PVTransition]()
    private var _currentTransitionIndex : Int = -1
    private var _previousTransitionIndex : Int = -1
    private var _scrollOffset : CGFloat {
        return scrollHorizontal ? _scrollView.contentOffset.x : _scrollView.contentOffset.y
    }
    private var _pageSize : CGFloat{
        return self.scrollHorizontal ? CGRectGetWidth(self._scrollView.bounds) : CGRectGetHeight(self._scrollView.bounds)
    }
    
    
    private let _scrollView : UIScrollView = {
        let scView = UIScrollView()
        scView.pagingEnabled = true
        scView.decelerationRate = UIScrollViewDecelerationRateFast
        scView.showsHorizontalScrollIndicator = true
        scView.showsVerticalScrollIndicator = false
        return scView
    }()
    
    init(frame: CGRect, numberOfPages: Int, horizontal: Bool = true) {
        scrollHorizontal = horizontal
        pageCount = numberOfPages
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        _scrollView.frame = self.bounds
        _scrollView.contentSize = scrollHorizontal ? pvs(self.bounds.width * CGFloat(pageCount), h: self.bounds.size.height) : pvs(self.bounds.width, h: self.bounds.height * CGFloat(pageCount))
        self.prepare()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        _scrollView.delegate = self
        self.insertSubview(_scrollView, atIndex: 0)
        interactiveActions.forEach({$0.target.hidden = true})
        animatedActions.forEach({$0.target.hidden = true})
    }
    
    func prepare(){
        interactiveActions.forEach { (anAction) -> () in
            anAction.setups()
        }
        animatedActions.forEach { (anAction) -> () in
            anAction.setups()
        }
        
        _transitions = (0 ..< pageCount + 2).map({_ in return PVTransition()})
        
        interactiveActions.forEach { (anAction) -> () in
            self._transitions[anAction.pageIndex + 1].interactiveActions.append(anAction)
        }
        
        animatedActions.forEach { (anAction) -> () in
            self._transitions[anAction.pageIndex + 1].appearAnimatedActions.append(anAction)
            if let disappearIndex = anAction.disappearPageIndex {
                self._transitions[disappearIndex + 1].disappearAnimatedActions.append(anAction)
            }
        }
        
    }
    
    func update(){
        let index : Int = pvClamp(Int(floor(_scrollOffset / _pageSize)) + 1, minValue: 0, maxValue: _transitions.count - 1)
        let currentTransition = _transitions[index]
        
        if _currentTransitionIndex != index {
            if index > _currentTransitionIndex {
                _previousTransitionIndex = index
                if _currentTransitionIndex >= 0 {
                    _transitions[_currentTransitionIndex].end()
                }
                currentTransition.start()
            } else {
                _previousTransitionIndex = _currentTransitionIndex
                if _currentTransitionIndex >= 0 {
                    _transitions[_currentTransitionIndex].start()
                }
                currentTransition.end()
            }
            _currentTransitionIndex = index
        }
        if index != _previousTransitionIndex && _previousTransitionIndex >= 0 {
            let previousTransition = _transitions[_previousTransitionIndex]
            if previousTransition.onStable {
//                previousTransition.onStable = false
                previousTransition.runRestartActions()
            }
        }

        var pageOffset = fmod(_scrollOffset, _pageSize)
        if pageOffset == 0 {
//            if _currentTransitionIndex != _previousTransitionIndex {
                currentTransition.start()
//            }
            _previousTransitionIndex = index
//            if !currentTransition.onStable {
//                currentTransition.onStable = true
//            }
        } else if currentTransition.onStable{
//            currentTransition.onStable = false
            currentTransition.runDisappearActions()
        }
        
        pageOffset += (pageOffset < 0) ? _pageSize : 0
        let progress = pageOffset / _pageSize
        
        currentTransition.update(progress, forwarding: index >= _previousTransitionIndex)
        
    }

    //MARK:- Public methods
    public func reload(){
        if let actions = dataSource?.interactiveActionsForParallaxView(self) {
            interactiveActions = actions
        }
        if let actions = dataSource?.animatedActionsForParallaxView(self) {
            animatedActions = actions
        }
        _transitions = []
        _currentTransitionIndex = -1
        _previousTransitionIndex  = -1
        _scrollView.contentOffset = CGPointZero
        prepare()
    }
    
    //MARK:- UIScrollViewDelegate
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        self.update()
    }
    
    
}




