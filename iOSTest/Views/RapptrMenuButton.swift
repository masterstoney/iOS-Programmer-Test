//
//  RapptrMenuButton.swift
//  iOSTest
//
//  Created by Tendaishe Gwini on 6/8/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

class RapptrMenuButton: UIButton {

    //MARK: - Properties
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    //MARK: - Methods

    private func setupButton() {
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8)
        layer.cornerRadius = 8.0
        setTitleColor(#colorLiteral(red: 0.1058823529, green: 0.1176470588, blue: 0.1215686275, alpha: 1), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        if #available(iOS 11.0, *) {
            contentHorizontalAlignment = .leading
        } else {
            // Fallback on earlier versions
            contentHorizontalAlignment = .left
        }
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
    }
    
}
