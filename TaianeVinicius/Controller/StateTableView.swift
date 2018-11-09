//
//  StateTableViewController.swift
//  TaianeVinicius
//
//  Created by DTI-DEV on 01/11/2018.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import UIKit

class StateTableView: UITableView {
    
    var statesManager = StatesManager.shared
    var lbEmptyList = UILabel()

    /*override func viewDidLoad() {
        super.viewDidLoad()
        
        lbEmptyList.text = "Lista de estados vazia"
        lbEmptyList.textAlignment = .center
        
        loadStates()
    }
    
    func loadStates() {
        statesManager.loadStates(with: context)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = statesManager.states.count
        
        tableView.backgroundView = count == 0 ? lbEmptyList : nil
        
        return count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = statesManager.states[indexPath.row].name

        return cell
    }
    
    
    func showAlert(with state: State?) {
        let title = state == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Nome do estado"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "IOF"
            textField.keyboardType = .decimalPad
        }
        
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            let state = state //?? State(context: self.context)
            state.name = alert.textFields?.first?.text
            
            do {
               // try self.context.save()
                // loadStates
            } catch {
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
       // present(alert, animated: true, completion: nil)
    }


}
