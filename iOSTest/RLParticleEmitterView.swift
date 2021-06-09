//
//  RLParticleEmitterView.swift
//  iOSTest
//
//  Created by Tendaishe Gwini on 6/9/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

class RLParticleEmitterView: UIView {
    
    //MARK: - Properties
    
    var animationDelegate: RLAnimationDelegate?
    private var particleEmitterLayer = CAEmitterLayer()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    
    //MARK: - Methods
    
    private func setupView() {
        
        particleEmitterLayer.emitterPosition = CGPoint(x: self.center.x, y: -96)
        particleEmitterLayer.emitterShape = .line
        particleEmitterLayer.emitterSize = CGSize(width: self.frame.size.width, height: 1)
        
        let developerEmitterCell = makeEmitterCell(image: UIImage(named: "hammer")!)
        let fireEmitterCell = makeEmitterCell(image: UIImage(named: "fire")!)
        let smileEmitterCell = makeEmitterCell(image: UIImage(named: "smile")!)
        particleEmitterLayer.emitterCells = [developerEmitterCell,fireEmitterCell,smileEmitterCell]
        
        
    }
    
    private func makeEmitterCell(image: UIImage) -> CAEmitterCell {
        
        let cell = CAEmitterCell()
        cell.birthRate = 3.0
        cell.lifetime = 8.0
        cell.velocity = 200
        cell.velocityRange = cell.velocity / 2
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 4
        cell.spin = 3
        cell.spinRange = .pi * 6
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05
        cell.contents = image.cgImage
        return cell
    }
    
    
    func animate() {
        
        self.layer.addSublayer(particleEmitterLayer)
        UIView.animate(withDuration: 5.0) {
            self.backgroundColor = .systemPink
        } completion: { _ in
            self.particleEmitterLayer.removeFromSuperlayer()
            self.animationDelegate?.completed(by: .particleEmitterView)
        }
    }
  
}
