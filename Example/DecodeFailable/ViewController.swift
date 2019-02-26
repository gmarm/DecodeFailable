//
//  ViewController.swift
//  DecodeFailable
//
//  Created by George Marmaridis on 01/17/2019.
//  Copyright (c) 2019 George Marmaridis. All rights reserved.
//

import UIKit
import DecodeFailable

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DecodeFailable Options
        DecodeFailableOptions.logsErrors = true
        DecodeFailableOptions.errorClosure = {
            print("You may track your error here")
        }
        
        // Mapping
        do {
            let getPeopleResponse = try decoder.decode(GetPeopleResponse.self,
                                                       from: peopleResponseData)
            print(getPeopleResponse)
        } catch(let error) {
            print(error)
        }
    }
    
    // MARK: Helpers
    lazy var peopleResponseData: Data = {
        let path = Bundle.main.path(forResource: "PeopleResponse", ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: path), options: [])
    }()
    let decoder = JSONDecoder()
}

