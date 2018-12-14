//
//  SettingsViewController.swift
//  TaianeVinicius
//
//  Created by user912249 on 10/12/18.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tfDolarRate: UITextField!
    @IBOutlet weak var tfIof: UITextField!
    @IBOutlet weak var stateTableView: UITableView!
    
    let settings = Settings.shared
    var statesManager = StatesManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        loadStates()
    }
    
    func loadStates() {
        statesManager.loadStates(with: context)
        stateTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tfDolarRate.text = String(settings.dolarRate)
        tfIof.text = String(settings.iof)
    }
    
    @IBAction func addState(_ sender: Any) {
        StateAlert.showAlert(view: self, with: nil, onCompletion: {(state) in
            self.loadStates()
            self.stateTableView.reloadData()
        })
    }
}

extension SettingsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statesManager.states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = statesManager.states[indexPath.row].name
        cell.detailTextLabel?.text = String(statesManager.states[indexPath.row].tax)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let state = statesManager.states[indexPath.row]
            
            context.delete(state)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension SettingsViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                stateTableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        default:
            stateTableView.reloadData()
        }
    }
}

