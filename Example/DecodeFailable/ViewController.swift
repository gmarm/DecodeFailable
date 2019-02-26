//
//  ViewController.swift
//  DecodeFailable
//
//  Created by George Marmaridis on 01/17/2019.
//  Copyright (c) 2019 George Marmaridis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var peopleResponseData: Data = {
        let path = Bundle.main.path(forResource: "PeopleResponse", ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: path), options: [])
    }()
    let decoder = JSONDecoder()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // loadPeopleResponseJSON()
        
        do {
            let getPeopleResponse = try decoder.decode(GetPeopleResponse.self, from: peopleResponseData)
            print(getPeopleResponse)
        } catch(let error) {
            print(error)
        }
        
    }
    
//    func loadPeopleResponseJSON() {
//        let path = Bundle.main.path(forResource: "PeopleResponse", ofType: "json")!
//        do {
//            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
//            let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
//            print(jsonResult)
//            if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
//                // do stuff
//            }
//        } catch {
//            // handle error
//        }
//
//    }
}

