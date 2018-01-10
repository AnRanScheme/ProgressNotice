//
//  ProgressAnimatedView.swift
//  ProgressNotice
//
//  Created by 安然 on 2018/1/8.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class ProgressAnimatedView: UIView {

    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            ringAnimatedLayer.removeFromSuperlayer()
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
        return CGSize(width: (self.radius+self.strokeThickness/2+5)*2,
                      height: (self.radius+self.strokeThickness/2+5)*2)
    }
    
    fileprivate func layoutAnimatedLayer() {
            self.layer.addSublayer(ringAnimatedLayer)
            let widthDiff = bounds.width - ringAnimatedLayer.bounds.width
            let heightDiff = bounds.height - ringAnimatedLayer.bounds.height
            ringAnimatedLayer.position = CGPoint(x: bounds.width - ringAnimatedLayer.bounds.width/2 - widthDiff/2,
                                     y: bounds.height - ringAnimatedLayer.bounds.height/2 - heightDiff/2)
    }
    
    public var radius: CGFloat = 4.0 {
        didSet {
            if oldValue != radius {
                ringAnimatedLayer.removeFromSuperlayer()
            }
            
            if superview != nil {
                layoutAnimatedLayer()
            }
        }
    }
    
    public var strokeThickness: CGFloat = 1.0 {
        didSet {
            ringAnimatedLayer.lineWidth = strokeThickness
        }
    }
    
    public var strokeEnd: CGFloat = 0.0 {
        didSet {
            ringAnimatedLayer.strokeEnd = strokeEnd
        }
    }
    
    public var strokeColor: UIColor = UIColor.blue {
        didSet {
            ringAnimatedLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    fileprivate lazy var ringAnimatedLayer: CAShapeLayer = {
        let arcCenter: CGPoint = CGPoint(x: self.radius+self.strokeThickness/2+5,
                                        y: self.radius+self.strokeThickness/2+5)
        
        let smoothedPath: UIBezierPath = UIBezierPath(arcCenter: arcCenter,
                                                      radius: self.radius,
                                                      startAngle: -(CGFloat.pi/2),
                                                      endAngle: CGFloat.pi * 3 / 2,
                                                      clockwise: true)
        let _ringAnimatedLayer = CAShapeLayer()
        _ringAnimatedLayer.contentsScale = UIScreen.main.scale
        _ringAnimatedLayer.frame = CGRect(x: 0,
                                          y: 0,
                                          width: arcCenter.x*2,
                                          height: arcCenter.y*2)
        _ringAnimatedLayer.fillColor = UIColor.clear.cgColor
        _ringAnimatedLayer.strokeColor = self.strokeColor.cgColor
        _ringAnimatedLayer.lineWidth = self.strokeThickness
        _ringAnimatedLayer.lineCap = kCALineCapRound
        _ringAnimatedLayer.lineJoin = kCALineJoinBevel
        _ringAnimatedLayer.path = smoothedPath.cgPath
        return _ringAnimatedLayer
    }()

}
