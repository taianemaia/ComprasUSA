//
//  ProductViewController.swift
//  TaianeVinicius
//
//  Created by DTI-DEV on 01/11/2018.
//  Copyright © 2018 TaianeVinicius. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var tfState: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var swCard: UISwitch!
    @IBOutlet weak var btAddPhoto: UIButton!
    @IBOutlet weak var btSave: UIButton!
    
    var product: Product!
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    var statesManager = StatesManager.shared
    
    override func viewWillAppear(_ animated: Bool) {
        statesManager.loadStates(with: context)
        
        configProduct()
        configValidate()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configPickerView()
    }
    
    func configProduct() {
        if(product != nil) {
            tfName.text = product.name
            
            if let image = product.image as? UIImage {
                ivImage.image = image
                btAddPhoto.setTitle(nil, for: .normal)
            }
            
            if let state = product.state, let index = statesManager.states.index(of: state) {
                tfState.text = state.name
                pickerView.selectRow(index, inComponent: 0, animated: true)
            }
            
            tfPrice.text = "\(product.price)" // Formatar com 2 casas
            swCard.isOn = product.onCard  
            // alterar label do botao
        }
      
        configValidate()
    }
    
    func configValidate() {
        btSave.isEnabled = self.enableButton()
        
        NotificationCenter.default.addObserver(forName: .UITextFieldTextDidChange, object: nil, queue: OperationQueue.main, using: {_ in
         
            self.btSave.isEnabled = self.enableButton()
         
        })
    }
    
    func enableButton() -> Bool {
        return tfName.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
            && tfPrice.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
            && tfState.text!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
        
    }
    
    func configPickerView() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [btCancel, btFlexibleSpace, btDone]
        
        tfState.inputView = pickerView
        tfState.inputAccessoryView = toolbar
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func cancel() {
        tfState.resignFirstResponder()
    }
    
    @objc func done() {
        tfState.text = statesManager.states[pickerView.selectedRow(inComponent: 0)].name
        cancel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveProduct(_ sender: Any) {
        if product == nil {
            product = Product(context: context)
        }
        
        product.name = tfName.text
        product.price = Double(tfPrice.text!)!
        product.onCard = swCard.isOn
        product.image = ivImage.image
        
        if !tfState.text!.isEmpty {
            product.state = statesManager.states[pickerView.selectedRow(inComponent: 0)]
        }
       
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addState(_ sender: Any) {
        StateAlert.showAlert(view: self, with: nil, onCompletion: {(state) in
            self.statesManager.loadStates(with: self.context)
            self.pickerView.reloadAllComponents()
            
            if let index = self.statesManager.states.index(of: state) {
                self.tfState.text = state.name
                self.pickerView.selectRow(index, inComponent: 0, animated: true)
            }
        })
    }
    
    @IBAction func addImage(_ sender: Any) {
    
        let alert = UIAlertController(title: "Selecionar foto do produto", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action: UIAlertAction) in
                self.selectPicture(sourceType: .camera)
            }
            alert.addAction(cameraAction)
        }
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default) { (action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        }
        alert.addAction(libraryAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
        
    }
}

extension ProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statesManager.states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = statesManager.states[row]
        return state.name
    }
}

extension ProductViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        ivImage.image = image
        btAddPhoto.setTitle(nil, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
