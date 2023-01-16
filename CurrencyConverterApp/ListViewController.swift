//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by 유상 on 2023/01/13.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var usdTextField: UITextField!
    @IBOutlet weak var currencyTable: UITableView!
    
    var rates: [(String, Double)]?
    
    var values = [String]()
    
    var usdValue: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Currency Converter Table"
        
        usdTextField.delegate = self
        
        currencyTable.delegate = self
        currencyTable.dataSource = self
        
        let currencyTableCellNib = UINib(nibName: "CurrencyTableCell", bundle: nil)
        currencyTable.register(currencyTableCellNib, forCellReuseIdentifier: "CurrencyTableCell")
        
        requestJson()
      
        
    }
    
    func requestJson() {
        NetworkLayer().requestJson { currencyModel in
            self.rates = currencyModel.rates.sorted { dic1, dic2 in
                dic1.key < dic2.key
            }
            
            DispatchQueue.main.async {
                self.currencyTable.reloadData()
            }
        }
    }

}




extension ListViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        usdValue = Int(usdTextField.text ?? "") ?? 0
        currencyTable.reloadData()
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableCell", for: indexPath) as! CurrencyTableCell
        

        cell.countryLabel.text = rates?[indexPath.row].0 ?? ""
        cell.valueLabel.text = String(format: "%.2f", ((rates?[indexPath.row].1 ?? 0) * Double(usdValue)))
        
        return cell
    }
    
    
}


