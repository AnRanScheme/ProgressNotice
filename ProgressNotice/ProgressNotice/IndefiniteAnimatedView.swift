//
//  IndefiniteAnimatedView.swift
//  ProgressNotice
//
//  Created by 安然 on 2018/1/8.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class IndefiniteAnimatedView: UIView {

    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            indefiniteAnimatedLayer.removeFromSuperlayer()
        }
            
        else {
            layoutAnimatedLayer()
        }
    }
    
    override var frame: CGRect {
        didSet {
            if oldValue != frame && superview != nil {
                layoutAnimatedLayer()
            }
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: (radius+strokeThickness/2+5)*2,
                      height: (radius+strokeThickness/2+5)*2)
    }
    
    fileprivate func layoutAnimatedLayer() {
        self.layer.addSublayer(indefiniteAnimatedLayer)
        let widthDiff = bounds.width-indefiniteAnimatedLayer.bounds.width
        let heightDiff = bounds.height-indefiniteAnimatedLayer.bounds.height
        indefiniteAnimatedLayer.position = CGPoint(x: bounds.width-indefiniteAnimatedLayer.bounds.width/2-widthDiff/2,
                                                   y: bounds.height-indefiniteAnimatedLayer.bounds.height/2-heightDiff/2)
    }
    
    public var radius: CGFloat = 4.0 {
        didSet {
            if oldValue != radius {
                indefiniteAnimatedLayer.removeFromSuperlayer()
            }
            
            if superview != nil {
                layoutAnimatedLayer()
            }
        }
    }
    
    public var strokeThickness: CGFloat = 1.0 {
        didSet {
            indefiniteAnimatedLayer.lineWidth = strokeThickness
        }
    }
    
    public var strokeEnd: CGFloat = 0.0 {
        didSet {
            indefiniteAnimatedLayer.strokeEnd = strokeEnd
        }
    }
    
    public var strokeColor: UIColor = UIColor.blue {
        didSet {
            indefiniteAnimatedLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    fileprivate lazy var indefiniteAnimatedLayer: CAShapeLayer = {
        let arcCenter: CGPoint = CGPoint(x: radius+strokeThickness/2+5,
                                         y: radius+strokeThickness/2+5)
        
        let smoothedPath: UIBezierPath = UIBezierPath(arcCenter: arcCenter,
                                                      radius: radius,
                                                      startAngle: CGFloat.pi*3/2,
                                                      endAngle: CGFloat.pi/2+CGFloat.pi*5,
                                                      clockwise: true)
        let _indefiniteAnimatedLayer = CAShapeLayer()
        _indefiniteAnimatedLayer.contentsScale = UIScreen.main.scale
        _indefiniteAnimatedLayer.frame = CGRect(x: 0,
                                          y: 0,
                                          width: arcCenter.x*2,
                                          height: arcCenter.y*2)
        _indefiniteAnimatedLayer.fillColor = UIColor.clear.cgColor
        _indefiniteAnimatedLayer.strokeColor = strokeColor.cgColor
        _indefiniteAnimatedLayer.lineWidth = strokeThickness
        _indefiniteAnimatedLayer.lineCap = kCALineCapRound
        _indefiniteAnimatedLayer.lineJoin = kCALineJoinBevel
        _indefiniteAnimatedLayer.path = smoothedPath.cgPath
        
        let maskLayer: CALayer = CALayer()
        let bundle = Bundle(for: IndefiniteAnimatedView.self)
        let url = bundle.url(forResource: "ProgressNotice",
                             withExtension: "bundle")
        guard let imageUrl = url else {
            return _indefiniteAnimatedLayer
        }
        let imageBundle = Bundle(url: imageUrl)
        
        guard let path = imageBundle?.path(forResource: "angle-mask", ofType: "png") else {
            return _indefiniteAnimatedLayer
        }
        maskLayer.contents = UIImage(contentsOfFile: path)
        maskLayer.frame = _indefiniteAnimatedLayer.frame
        _indefiniteAnimatedLayer.mask = maskLayer
        
        let animationDuration: TimeInterval = 1
        let linearCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi*2
        animation.duration = animationDuration
        animation.timingFunction = linearCurve
        animation.isRemovedOnCompletion = false
        animation.repeatCount = Float.infinity
        animation.fillMode = kCAFillModeForwards
        animation.autoreverses = false
        _indefiniteAnimatedLayer.mask?.add(animation, forKey: "rotate")
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration
        animationGroup.repeatCount = Float.infinity
        animationGroup.isRemovedOnCompletion = false
        animationGroup.timingFunction = linearCurve
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = 0.015
        strokeStartAnimation.toValue = 0.515
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.485
        strokeEndAnimation.toValue = 0.985
        
        animationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        _indefiniteAnimatedLayer.add(animationGroup, forKey: "progress")
 
        return _indefiniteAnimatedLayer
    }()

}
