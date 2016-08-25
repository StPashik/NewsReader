//
//  ViewController+STLib.swift
//  dostineks
//
//  Created by StPashik on 10.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
}
