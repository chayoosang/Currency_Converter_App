//
//  NetworkLayer.swift
//  CurrencyConverterApp
//
//  Created by 유상 on 2023/01/15.
//

import Foundation



struct NetworkLayer {
    
    enum NetowrkError: Error {
        case badUrl
        case badStatus
    }
    
    func requestJson(completion: @escaping (CurrencyModel) -> Void)  {
        let urlString = "https://open.er-api.com/v6/latest/USD"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do{
                let currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
                
                completion(currencyModel)
                
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
    
    static func requestJsonAsyncAwait() async throws -> CurrencyModel {
        let urlString = "https://open.er-api.com/v6/latest/USD"
        guard let url = URL(string: urlString) else {
            throw NetowrkError.badUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw NetowrkError.badStatus
            }
            
            let currencyModel = try JSONDecoder().decode(CurrencyModel.self, from: data)
            
            return currencyModel
        } catch {
            throw error
        }
    }

}

