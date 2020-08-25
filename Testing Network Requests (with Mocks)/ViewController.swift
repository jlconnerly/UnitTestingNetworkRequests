//
//  ViewController.swift
//  Testing Network Requests (with Mocks)
//
//  Created by Jake Connerly on 8/25/20.
//  Copyright © 2020 jake connerly. All rights reserved.
//

import UIKit

protocol URLSessionProtocol {
    // in order to call the dataTask function, we had to pull this from the original URLSession
    // then add it to our protocol URLSessionProtocol in order to call dataTask
    // in doing this, we decoupled session and URLSession which is a difficult dependency to test
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class ViewController: UIViewController {
    
    @IBOutlet weak var sendRequestButton: UIButton!
    private var dataTask: URLSessionDataTask?
    // var session had an initial implicit type of URLSession
    // now we are adding the explicit type URLSessionProtocol
    var session: URLSessionProtocol = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendRequestTapped(_ sender: UIButton) {
        searchForBook(terms: "Ready player one")
    }
    
    func searchForBook(terms: String) {
        guard let encodedTerms = terms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "https://itunes.apple.com/search?" + "media=ebook&term=\(encodedTerms)") else { return }
        let request = URLRequest(url: url)
        dataTask = session.dataTask(with: request) {
            [weak self] (data: Data?, response: URLResponse?, error: Error?)
            -> Void in
            guard let self = self else { return }
            let decoded = String(data: data ?? Data(), encoding: .utf8)
            print("response: \(String(describing: response))")
            print("data: \(String(describing: decoded))")
            print("error: \(String(describing: error))")
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.dataTask = nil
                self.sendRequestButton.isEnabled = true
            }
            
        }
        sendRequestButton.isEnabled = false
        dataTask?.resume()
    }
}
extension URLSession: URLSessionProtocol { }
