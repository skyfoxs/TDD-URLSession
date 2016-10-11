//
//  AccountAPI.swift
//  Prototype
//
//  Created by Supakit Thanadittagorn on 10/11/2559 BE.
//  Copyright © 2559 Supakit Thanadittagorn. All rights reserved.
//

import UIKit

protocol AccountAPIDelegate:class {
    func didFinishLoading(accounts: [Account])
}

class AccountAPI {
    weak var delegate: AccountAPIDelegate?
    var session = URLSession(configuration: URLSessionConfiguration.default)

    func list(for username: String) {
        let dataTask = session.dataTask(with: URL(string: "https://twitter.com/\(username.lowercased())/following")!) { (data, urlResponse, error) in
            print(urlResponse)
            self.delegate?.didFinishLoading(accounts: [])
        }
        dataTask.resume()
    }
}
