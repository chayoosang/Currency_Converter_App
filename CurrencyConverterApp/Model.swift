//
//  Model.swift
//  CurrencyConverterApp
//
//  Created by 유상 on 2023/01/14.
//

import Foundation

/*
 {
   "result": "success",
   "provider": "https://www.exchangerate-api.com",
   "documentation": "https://www.exchangerate-api.com/docs/free",
   "terms_of_use": "https://www.exchangerate-api.com/terms",
   "time_last_update_unix": 1673568151,
   "time_last_update_utc": "Fri, 13 Jan 2023 00:02:31 +0000",
   "time_next_update_unix": 1673655981,
   "time_next_update_utc": "Sat, 14 Jan 2023 00:26:21 +0000",
   "time_eol_unix": 0,
   "base_code": "USD",
   "rates": {
     "USD": 1,
     "AED": 3.6725,
   }
 }
 */


struct CurrencyModel: Codable {
    let result: String
    let provider: String
    let baseCode: String
    let rates: [String : Double]
    let time: Int
    
    enum CodingKeys: String, CodingKey {
        case result
        case provider
        case baseCode = "base_code"
        case rates
        case time = "time_last_update_unix"
    }
}
