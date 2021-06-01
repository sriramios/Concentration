//
//  UIStoryboardExtension.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import Foundation
import UIKit

enum AppStoryboard: String {
    case main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: Bundle.main)
    }
    
    func instantiate<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let className = (viewControllerClass as UIViewController.Type).storyboardID
        if let viewController = instance.instantiateViewController(withIdentifier: className) as? T {
            return viewController
        } else {
            fatalError("Invalid Viewcontroller ID")
        }
    }
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
}
