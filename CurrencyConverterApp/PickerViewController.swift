//
//  PickerViewController.swift
//  CurrencyConverterApp
//
//  Created by 유상 on 2023/01/14.
//

import UIKit

class PickerViewController: UIViewController {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var selectedCurrencyName: UILabel!
    
    @IBOutlet weak var usdTextField: UITextField!
    
    @IBOutlet weak var selectedTextField: UITextField!
    
    
    var rates: [(String, Double)]?
    
    var selectedRow = 0 {
        didSet {
            selectedCurrencyName.text = rates?[selectedRow].0
            selectedTextField.text = calculateCurrency()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Currency Converter Picker"
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        usdTextField.delegate = self
        
        requestJson()
    }
    
    
    
    func calculateCurrency() -> String {
        let selectedValue = rates?[selectedRow].1 ?? 0
        let usdValue = Double(usdTextField.text ?? "") ?? 0
        
        let result = String(format: "%.2f", (selectedValue * usdValue))
        return result
    }
    
    
    func requestJson() {
        let urlString = "https://open.er-api.com/v6/latest/USD"
        guard let url = URL(string: urlString) else {
            return
        }
                
        // data task
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }
            
            do{
                let currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
                
                self.rates = currencyModel.rates.sorted { dic1, dic2 in
                    dic1.key < dic2.key
                }
                
                DispatchQueue.main.async {
                    self.currencyPicker.reloadAllComponents()
                }
                
                
                
            } catch {
                print(error)
            }
            
        }.resume()
    }
    


}


extension PickerViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        selectedTextField.text = calculateCurrency()
    }
}


extension PickerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rates?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                
        return rates?[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedRow = row
        
        
    }
}


