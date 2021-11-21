//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {

    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "81F0828E-651C-4CF0-A3A2-8A9FA2D09CC6"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let request = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: request)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    delegate?.didUpdateCurrency(self, coin: parseJSON(data: safeData)!)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return CoinModel(originalCurrencyName: decodedData.asset_id_base, convertedCurrencyName: decodedData.asset_id_quote, rate: decodedData.rate)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
