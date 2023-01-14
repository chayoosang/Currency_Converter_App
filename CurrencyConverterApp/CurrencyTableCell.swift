//
//  CurrencyTableCell.swift
//  CurrencyConverterApp
//
//  Created by 유상 on 2023/01/14.
//

import UIKit

class CurrencyTableCell: UITableViewCell {
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
