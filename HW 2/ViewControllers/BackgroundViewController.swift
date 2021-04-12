//
//  BackgroundViewController.swift
//  Colorized
//
//  Created by ErrorV9 on 09.04.2021.
//  Copyright © 2021 Vlad Nikitenkov. All rights reserved.
//

import UIKit

protocol ColorizedViewControllerDelegate {
    func setColor(_ color: UIColor)
}


class BackgroundViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsVC = segue.destination as! ColorizedViewController
        
        settingsVC.delegate = self
        settingsVC.viewColor = view.backgroundColor
    }
}
 
extension BackgroundViewController: ColorizedViewControllerDelegate{
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
    
}

    
