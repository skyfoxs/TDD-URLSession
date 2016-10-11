//
//  ViewController.swift
//  Prototype
//
//  Created by Supakit Thanadittagorn on 10/11/2559 BE.
//  Copyright © 2559 Supakit Thanadittagorn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, AccountAPIDelegate {

    var accountApi = AccountAPI()

    override func viewDidLoad() {
        super.viewDidLoad()

        accountApi.delegate = self
        accountApi.list(for: "rwenderlich")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didFinishLoading(accounts: [Account]) {
        print("Finish")
    }
}

