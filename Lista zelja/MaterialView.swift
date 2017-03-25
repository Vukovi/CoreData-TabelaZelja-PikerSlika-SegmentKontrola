//
//  MaterialView.swift
//  Lista zelja
//
//  Created by Vuk on 3/22/17.
//  Copyright © 2017 Vuk. All rights reserved.
//

import UIKit

private var materialKey = false // ovu promenljivu pravim zbog promenljive materijalDesign, jer se u ekstenziji ne mogu da deklarisati promenljive

extension UIView {

    @IBInspectable var materialDesign: Bool { //ovim @IBInspectable se dodaje dodatna opcija UIView-u u meniju storyboard-a
            get {
                return materialKey
            } set {
                materialKey = newValue
                
                if materialKey {
                    self.layer.masksToBounds = false
                    self.layer.cornerRadius = 3
                    self.layer.shadowOpacity = 0.8
                    self.layer.shadowRadius = 3
                    self.layer.shadowOffset = CGSize(width: 0, height: 2)
                    self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1).cgColor
                } else {
                    self.layer.cornerRadius = 3
                    self.layer.shadowOpacity = 0.8
                    self.layer.shadowRadius = 3
                    self.layer.shadowColor = nil
                }
            }
        
    }
}
