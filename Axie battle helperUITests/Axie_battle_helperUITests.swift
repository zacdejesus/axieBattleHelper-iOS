//
//  Axie_battle_helperUITests.swift
//  Axie battle helperUITests
//
//  Created by Alejandro de Jesus on 12/10/2021.
//

import XCTest

class Axie_battle_helperUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStepperExistence() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        
        let stepper = app.steppers["energyStepper"]
        XCTAssertTrue(stepper.isHittable)
        XCTAssertTrue(stepper.exists)
    }
    
    func testAumentInEnergyLabel() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let buttonEndTurn = app.buttons["endTurnButton"]
        buttonEndTurn.tap()
        let totalEnemyEnergyLabel = app.staticTexts["totalEnemyEnergyLabel"]
        XCTAssertTrue(totalEnemyEnergyLabel.exists)
        XCTAssertEqual(totalEnemyEnergyLabel.label, "5")
        buttonEndTurn.tap()
        XCTAssertEqual(totalEnemyEnergyLabel.label, "7")
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
