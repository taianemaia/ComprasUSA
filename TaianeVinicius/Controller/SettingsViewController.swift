//
//  SettingsViewController.swift
//  TaianeVinicius
//
//  Created by user912249 on 10/12/18.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tfDolarRate: UITextField!
    @IBOutlet weak var tfIof: UITextField!
    
    let settings = Settings.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfDolarRate.text = String(settings.dolarRate)
        tfIof.text = String(settings.iof)

        print(settings.dolarRate)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
