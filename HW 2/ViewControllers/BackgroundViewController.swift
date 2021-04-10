//
//  BackgroundViewController.swift
//  Colorized
//
//  Created by ErrorV9 on 09.04.2021.
//  Copyright © 2021 Vlad Nikitenkov. All rights reserved.
//

import UIKit

class BackgroundViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as?
                ColorizedViewController else { return }
        settingsVC.colorView?.backgroundColor = view.backgroundColor
        
}

}
