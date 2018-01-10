//
//  ViewController.swift
//  ProgressNotice
//
//  Created by 安然 on 2018/1/8.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    lazy var backLayer: RadialGradientLayer = {
        let backLayer = RadialGradientLayer()
        return backLayer
    }()
    
    lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.clear
        backView.frame = view.frame
        return backView
    }()
    
    lazy var ringView: ProgressAnimatedView = {
        let ringView = ProgressAnimatedView()
        ringView.center = view.center
        ringView.radius = 25
        ringView.strokeThickness = 3
        return ringView
    }()

    lazy var indefiniteAnimatedView: IndefiniteAnimatedView = {
        let indefiniteAnimatedView = IndefiniteAnimatedView()
        indefiniteAnimatedView.center = view.center
        indefiniteAnimatedView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        indefiniteAnimatedView.radius = 25
        indefiniteAnimatedView.strokeThickness = 3
        return indefiniteAnimatedView
    }()
    
//    lazy var indefiniteAnimatedView1:   = {
//        let indefiniteAnimatedView = SVIndefiniteAnimatedView()
//        indefiniteAnimatedView.center = view.center
//        indefiniteAnimatedView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
//        indefiniteAnimatedView.radius = 25
//        indefiniteAnimatedView.strokeThickness = 3
//        return indefiniteAnimatedView
//    }()
    
    lazy var imageView: UIImageView = {
        let bundle = Bundle(for: IndefiniteAnimatedView.self)
        let url = bundle.url(forResource: "ProgressNotice",
                             withExtension: "bundle")

        let imageBundle = Bundle(url: url!)

        let path = imageBundle?.path(forResource: "angle-mask@3x", ofType: "png")

        let v = UIImageView(image: UIImage(contentsOfFile: path!))
//        NSString *bundlePath = [[NSBundlemainBundle]pathForResource:@"SourcesBundle"ofType:@"bundle"];
//
//        NSBundle *resourceBundle = [NSBundlebundleWithPath:bundlePath];
//        let bundlePath = Bundle.main.path(forResource: "ProgressNotice", ofType: "bundle")
//        let resourceBundle = Bundle(path: bundlePath ?? "")
//
//        let path = resourceBundle?.path(forResource: "angle-mask", ofType: "png")
//        let v = UIImageView(image: UIImage(contentsOfFile: path!))
        // let v = UIImageView(image: UIImage(named: "ProgressNotice.bundle/angle-mask"))
        v.center = view.center
        v.sizeToFit()
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(backView)
//        backView.layer.insertSublayer(backLayer, at: 0)
//        backLayer.frame = view.frame
//        backLayer.gradientCenter = view.center
//        backLayer.setNeedsDisplay()
        
//        view.addSubview(ringView)
//
//        var progress: CGFloat = 0
//
//        if #available(iOS 10.0, *) {
//            let timer = Timer(timeInterval: 0.01, repeats: true, block: {[unowned self] timer in
//                progress += 0.003
//                self.ringView.strokeEnd = progress
//                if progress >= 1 {
//                    timer.invalidate()
//                }
//
//            })
//            RunLoop.current.add(timer, forMode: .commonModes)
//        }
        view.addSubview(indefiniteAnimatedView)

        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

