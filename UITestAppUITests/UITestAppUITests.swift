import XCTest

class UITestAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // This is the first view controller /////
        // =/////////////////////////////////=/////
        
        // get table using accessibilityIdentifier
        let tableView = app.tables["MyTable"]
        
        // it's inly example
        XCTAssert(tableView.cells.count == 3)
                         
        // get array of cells with accessibilityIdentifier
        let cells = tableView.cells.containing(.cell, identifier: "myCell")
        
        // get the text of the second element of cell's array (numeration starts from 0)
        let cellLabelText = cells.staticTexts.element(boundBy: 2).label
        
        // check that the text like the text, that we have (it's only Example - "Some")
        XCTAssertEqual(cellLabelText, "Some")
        
        // pick up on the cell of the second element of array (numeration starts from 0)
        cells.staticTexts.element(boundBy: 2).tap()
        
        // This is the second view controller /////
        // =/////////////////////////////////=/////
        
        // check that label's text like the text of label of the cell
        XCTAssertEqual(app.staticTexts["myLabel"].label, cellLabelText)
        
        // get our textField
        let textField = app.otherElements.textFields["myTextField"]
        
        // pick up on textField
        textField.tap()
        
        // put in new value into text field
        textField.typeText("Some new value")
        
        // check the value to necessary value (for text only - "Some new value")
        XCTAssertEqual(textField.value as? String ?? "", "Some new value")
        
        // pick up the button
        app.buttons["myBackButton"].tap()
        
        // This is the first view controller AGAIN /////
        // =/////////////////////////////////=/////
        
        // check that we have the table with our identifier accessibilityIdentifier
        let tableViewNew = app.tables.containing(.table, identifier: "MyTable")
        
        // and cell too
        let cellNew = tableViewNew.cells.containing(.cell, identifier: "myCell")
        
        // get the updated text of the cell, that were changed
        let updatedText = cellNew.staticTexts.element(boundBy: 2).label
        
        // check text updating
        XCTAssertEqual(updatedText, "Some new value")
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
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
