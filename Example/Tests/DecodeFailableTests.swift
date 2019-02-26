//
//  DecodeFailableTests.swift
//  DecodeFailable
//
//  Created by George Marmaridis on 01/17/2019.
//  Copyright (c) 2019 George Marmaridis. All rights reserved.
//

import Quick
import Nimble
import DecodeFailable

class DecodeFailableTests: QuickSpec {
    override func spec() {
        describe("a GetPeopleResponse mapped with DecodeFailable") {
            var response: GetPeopleResponse!
            let peopleResponseData: Data = {
                let path = Bundle.main.path(forResource: "PeopleResponse", ofType: "json")!
                return try! Data(contentsOf: URL(fileURLWithPath: path), options: [])
            }()
            let decoder = JSONDecoder()
            
            context("when the response is being mapped") {
                beforeEach {
                    do {
                        response = try decoder.decode(GetPeopleResponse.self, from: peopleResponseData)
                    } catch(let error) {
                        print(error)
                    }
                }
                
                it("is mapped correctly") {
                    expect(response.people.count).to(be(2))
                    
                    if let firstPerson = response.people.first {
                        expect(firstPerson.id).to(equal("asd234fd"))
                        expect(firstPerson.firstName).to(equal("Jane"))
                        expect(firstPerson.lastName).to(equal("Doe"))
                        expect(firstPerson.age).to(equal(24))
                        expect(firstPerson.isMarried).to(be(true))
                    } else {
                        XCTFail("People array is empty")
                    }
                    
                    if let secondPerson = response.people.last {
                        expect(secondPerson.id).to(equal("a234fdsf"))
                        expect(secondPerson.firstName).to(equal("John"))
                        expect(secondPerson.lastName).to(equal("Johnson"))
                        expect(secondPerson.age).to(equal(43))
                        expect(secondPerson.isMarried).to(be(true))
                    } else {
                        XCTFail("People array is empty")
                    }
                }
            }
            
            context("when a closure set", {
                var closureCalledCount = 0
                
                beforeEach {
                    DecodeFailableOptions.errorClosure = { _ in
                        closureCalledCount += 1
                    }
                    do {
                        response = try decoder.decode(GetPeopleResponse.self, from: peopleResponseData)
                    } catch(let error) {
                        print(error)
                    }
                }
                
                afterEach {
                    DecodeFailableOptions.errorClosure = nil
                }
                
                it("calls the closure") {
                    expect(closureCalledCount).to(equal(4))
                }
            })
        }
    }
}
