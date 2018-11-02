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
    @IBOutlet weak var stateTableView: UITableView!
    
    let settings = Settings.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tfDolarRate.text = String(settings.dolarRate)
        tfIof.text = String(settings.iof)

        print(settings.dolarRate)
    }
}

extension SettingsViewController : UITableViewDelegate {
    
}

extension SettingsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
}
