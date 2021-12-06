//
//  Axie_battle_helperTests.swift
//  Axie battle helperTests
//
//  Created by Alejandro de Jesus on 12/10/2021.
//

import XCTest
@testable import Axie_battle_helper

class Axie_battle_helperTests: XCTestCase {

    var viewController: AxieHelperViewController!
    
    override func setUpWithError() throws {
        super.setUp()
        viewController = AxieHelperViewController()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func test_valid_state_after_turn() throws {
        XCTAssertEqual(viewController.totalEnemyEnergy, 3)
        viewController.handleEndTurn()

        XCTAssertEqual(viewController.totalEnemyEnergy, 5)
    }
    
    
    func test_valid_state_after_multiple_turns() throws {
        // Max amount of energy in this game is 10
        
        XCTAssertEqual(viewController.totalEnemyEnergy, 3)
        
        let randonInt = Int.random(in: 11...1000)
        
        for _ in 1...randonInt {
            viewController.handleEndTurn()
        }

        
        XCTAssertEqual(viewController.totalEnemyEnergy, 10)
    }
}
