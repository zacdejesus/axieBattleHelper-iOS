//
//  SlpService.swift
//  Axie battle helper
//
//  Created by Alejandro de Jesus on 13/10/2021.
//

import Foundation

struct SlpService {
    
    let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/SLP/USD")
    
    let key = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func fetchSlpData(success: @escaping (SlpData) -> Void, err: @escaping () -> Void) {
        guard let url = url else { return }
        
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "X-CoinAPI-Key")
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else { return }
            do {
                let slpData2 = try JSONDecoder().decode(SlpData.self, from: data)
                success(slpData2)
            } catch {
                err()
            }
        }).resume()
    }
}
