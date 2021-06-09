//
//  RLLogoView.swift
//  iOSTest
//
//  Created by Tendaishe Gwini on 6/9/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

class RLLogoView: UIView {

    //MARK: - Properties
    
    private var outerShapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let yDistance = CGFloat(200 / 3)
        let startPoint = CGPoint(x: 220 - (sin(.pi/3) * 90), y: ((220 - yDistance) + (cos(.pi/3) * 90)))
        let bendPoint = CGPoint(x: 220 - (sin(.pi/3) * 60), y: ((220 - yDistance) + (cos(.pi/3) * 60)))
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: 120, y: 220))
        path.addLine(to: CGPoint(x: 20, y: 220 - yDistance))
        path.addLine(to: CGPoint(x: 20, y: 20 + yDistance))
        path.addLine(to: CGPoint(x: 120, y: 20))
        path.addLine(to: CGPoint(x: 220, y: 20 + yDistance))
        path.addLine(to: CGPoint(x: 220, y: 220 - yDistance))
        path.addLine(to: bendPoint)
        path.addLine(to: CGPoint(x: 120, y: 140))
        path.lineWidth = 20
        layer.path = path.cgPath
        layer.lineWidth = 20
        layer.fillColor = nil
        layer.strokeColor = #colorLiteral(red: 0.168627451, green: 0.7529411765, blue: 0.9843137255, alpha: 1).cgColor
        return layer
    }()
    
    private var innerShapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 80, y: 100))
        path.addCurve(to: CGPoint(x: 160, y: 140), controlPoint1: CGPoint(x: 150, y: 100), controlPoint2: CGPoint(x: 170, y: 100))
        layer.path = path.cgPath
        layer.lineWidth = 20
        layer.fillColor = nil
        layer.strokeColor = #colorLiteral(red: 0.8666666667, green: 0.8705882353, blue: 0.862745098, alpha: 1).cgColor
        return layer
    }()
    
    var animationDelegate: RLAnimationDelegate?
    
    //MARK: - Initializers & Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.addSublayer(outerShapeLayer)
        self.layer.addSublayer(innerShapeLayer)
    }
    
    //MARK: - Methods
    
    func animate() {
        
        backgroundColor = .clear
        CATransaction.begin()
        
        let outerStrokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        outerStrokeEndAnimation.fromValue = 0.0
        outerStrokeEndAnimation.toValue = 1.0
        outerStrokeEndAnimation.duration = 2.5
        outerStrokeEndAnimation.beginTime = 0.0
        
        let innerStrokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        innerStrokeEndAnimation.fromValue = 0.0
        innerStrokeEndAnimation.toValue = 1.0
        innerStrokeEndAnimation.duration = 2.5
        innerStrokeEndAnimation.beginTime = 0.0
        
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else {return}
            self.animationDelegate?.completed(by: .logoView)
        }
        
        outerShapeLayer.add(outerStrokeEndAnimation, forKey: "drawOuterLayerAnim")
        innerShapeLayer.add(innerStrokeEndAnimation, forKey: "drawInnerLayerAnim")
        CATransaction.commit()
        
    }
    

}
