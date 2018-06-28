//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Gina Sprint on 6/28/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    
    override func awakeFromNib() {
        splitViewController?.delegate = self
        
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        // secondaryViewController is detail
        // primaryViewController is the master
        // adding to the face that I am split view controller on an iphone and I want to collapse the detail onto the primary. Should I do it?
        // return true: don't do it (don't want that collapsing to happen)
        // return false: do it
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "chooseTheme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = Theme.themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            // split view in on ipads and + phones
             if let themeName = (sender as? UIButton)?.currentTitle, let theme = Theme.themes[themeName] {
                cvc.theme = theme
             }
        }
        else if let cvc = lastSeguedToConcentrationViewController {
            // save last CVC so we can show it again instead of segue to create new one and reset the game
            // for phones not using split view, e.g. non ipads and +
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = Theme.themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else {
                performSegue(withIdentifier: "chooseTheme", sender: sender)
        }
    }

}
