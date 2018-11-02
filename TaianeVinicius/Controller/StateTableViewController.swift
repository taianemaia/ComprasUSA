//
//  StateTableViewController.swift
//  TaianeVinicius
//
//  Created by DTI-DEV on 01/11/2018.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import UIKit

class StateTableViewController: UITableViewController {
    
    var lbEmptyList = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbEmptyList.text = "Lista de estados vazia"
        lbEmptyList.textAlignment = .center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 0
        
        tableView.backgroundView = count == 0 ? lbEmptyList : nil
        
        return count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...

        return cell
    }


}
