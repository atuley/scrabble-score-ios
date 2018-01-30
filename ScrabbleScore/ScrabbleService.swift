//
//  ScrabbleService.swift
//  ScrabbleScore
//
//  Created by Alex Tuley on 1/29/18.
//  Copyright © 2018 Alex Tuley. All rights reserved.
//

import Foundation

protocol ScrService {
    func getScore(with barcode: String, completionHandler: @escaping (ScrabbleScore?, Error?) -> Void)
    func cancel()
}

class ScrabbleService: NSObject, ScrService, URLSessionDelegate {
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: OperationQueue.main)
    }()
    
    func getScore(with word: String, completionHandler: @escaping (ScrabbleScore?, Error?) -> Void) {
        let scrabbleUrl = "http://INSERTIPHERE:8080/score?word=\(word)"

        guard let request = URL(string: scrabbleUrl) else { return }
        
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                completionHandler(nil, error)
            }
            guard let data = data else { return }
            
            self.parseJSON(data: data, completionHandler: completionHandler)
        }
        dataTask.resume()
    }
    
    func cancel() {
        // Cancel any web service operations
    }
    
    private func parseJSON(data: Data, completionHandler: @escaping (ScrabbleScore?, Error?) -> Void) {
        do {
            if let dataAsJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let wrd = dataAsJSON["word"] as? String,
                let scr = dataAsJSON["score"] as? Int  {
                
                let scrScore = ScrabbleScore(word: wrd, score: scr)
                completionHandler(scrScore,nil)
            } else {
                completionHandler(nil, nil)
            }
        } catch let error as NSError {
            completionHandler(nil, error)
            return
            
        }
    }
}
