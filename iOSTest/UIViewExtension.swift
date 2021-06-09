//
//  UIViewExtension.swift
//  iOSTest
//
//  Created by Tendaishe Gwini on 6/9/21.
//  Copyright © 2021 D&ATechnologies. All rights reserved.
//

import UIKit

extension UIView {
    
    /**Constrains view to all edges of its supervew.*/
    func constrainToSuper() {
        
        if let superview = superview {
            self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
}
