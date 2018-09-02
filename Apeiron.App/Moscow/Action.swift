//
//  Action.swift
//  Apeiron.App
//
//  Created by Denis Bystruev on 01/09/2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit

/// Action to perform when annotation pin is tapped on the map view
///
/// — none: no action
/// - openURL: open an URL with open(_:options:completionHandler:)
/// - performSegue: perform a segue with performSegue(withIdentifier:sender:)
enum Action {
    case none
    case openURL(String)
    case performSegue(String)
    
    /// Performs an action determined by self
    func perform() {
        // check which action to perform
        switch self {
        case .none:
            // no action to perform
            break
        case .openURL(let scheme):
            // check that we can create a URL from the scheme ("scheme://")
            guard let url = URL(string: scheme) else {
                print("\(#function): can't convert a \(scheme) to URL")
                break
            }
            
            // check that there is an application installed
            guard UIApplication.shared.canOpenURL(url) else {
                print("\(#function): an app to open a \(scheme) is not installed")
                break
            }
            
            // open the URL
            UIApplication.shared.open(url) { success in
                if !success {
                    print("\(#function): could not open a \(scheme)")
                }
            }
        case .performSegue(let identifier):
            // get the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // get the Moscow view controller
            let moscowViewController = storyboard.instantiateViewController(withIdentifier: "MoscowViewController")
            
            // transition from the Moscow view controller to the new one
            moscowViewController.performSegue(withIdentifier: identifier, sender: moscowViewController)
        }
    }
}
