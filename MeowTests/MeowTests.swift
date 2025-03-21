//
//  MeowTests.swift
//  MeowTests
//
//  Created by Marc on 20/11/20.
//

import XCTest
import Moya
@testable import Meow

class MeowTests: XCTestCase {
    var dataSource: CategoriesDataSource!
    let actionDelegate = CategoryPickerAction()
    
    override func setUp() {
        super.setUp()
        dataSource = CategoriesDataSource(withDelegate: actionDelegate)
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

/// test case for CatViewModel
extension MeowTests {
    func testFetchCat() {
        let expectation = XCTestExpectation(description: "Expected Success with cat image URL")
        let viewModel = CatViewModel()
        viewModel.fetchCat { result in
            switch result {
            case .success :
                XCTAssertEqual(viewModel.imgURL.isEmpty, false, "Expected cat image url is available")
            default:
                XCTFail("Function returned error whereas it was expected to succeed.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchNoCat() {
        let viewModel = CatViewModel(dataSource: dataSource, stubClosure: MoyaProvider<CatManagerTarget>.immediatelyStub, endpointClosure: customErrorEndpointClosure)
        let expectation = XCTestExpectation(description: "No cat image URL")
        // expected completion to fail
        viewModel.fetchCat { result in
            switch result {
            case .success :
                XCTFail("Function returned success whereas it was expected to error.")
            default:
                XCTAssertEqual(viewModel.imgURL.isEmpty, true, "Expected no cat image url is available")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testfetchCatByCategory() {
        let expectation = XCTestExpectation(description: "Expected Success wiht same id")
        let catBoxes = Category(id: 5, name: "boxes")
        let viewModel = CatViewModel()
        viewModel.fetchCatByCategory(categoryID: catBoxes.id!) { result in
            switch result {
            case .success :
                let category = viewModel.category
                XCTAssertEqual(category?.id, catBoxes.id, "Expected id is same")
            default:
                XCTFail("Function returned error whereas it was expected to succeed.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func customErrorEndpointClosure(_ target: CatManagerTarget) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                    sampleResponseClosure: { .networkResponse(200, Data()) },
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers)
    }
    
    ///test with local sample data to isolate internet connection issues
    func customSampleResponseEndpointClosure(_ target: CatManagerTarget) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
    }
}

/// test case for CategoryDataSource
extension MeowTests {
    
    enum endpointType {
      case sample
      case error
    }
    
    func testEmptyValueInDataSource() {
        dataSource.data.value = []
        let pickerView = UIPickerView()
        pickerView.dataSource = dataSource
        // expected one compenent
        XCTAssertEqual(dataSource.numberOfComponents(in: pickerView), 1, "Expected one component in pick view")
        // expected zero row
        XCTAssertEqual(dataSource.pickerView(pickerView, numberOfRowsInComponent: 0), 0, "Expected no cell in pick view")
    }
    
    func testValueInDataSource() {
        let catBoxes = Category(id: 5, name: "boxes")
        let clothes = Category(id: 15, name: "clothes")
        self.dataSource.data.value = [catBoxes, clothes]
        let pickerView = UIPickerView()
        pickerView.dataSource = dataSource
        // expected one compenent
        XCTAssertEqual(dataSource.numberOfComponents(in: pickerView), 1, "Expected one component in pick view")

        // expected 2 row
        XCTAssertEqual(dataSource.pickerView(pickerView, numberOfRowsInComponent: 0), 2, "Expected two row in pick view")
    }
}

class CategoryPickerAction: ViewControllerDelegate {
    
    var isItemSelectedSuccessFullCalled = false
    var selectedRow = -1
    
    func categoriesPickerView(_ categoriesPickerView: UIPickerView, didSelectRow row: Int) {
        selectedRow = row
        isItemSelectedSuccessFullCalled = true
    }
}

extension CatManagerTarget {
    var testSampleData: Data {
        switch self {
        case .fetchCat:
            let bundleDoingTest = Bundle(for: MeowTests.self)
            let url = bundleDoingTest.url(forResource: "Cat", withExtension: "json")
            guard let testURL = url else { return Data() }
            return try! Data(contentsOf: testURL)
        case .getCategories:
            return Data()
        case .fetchCatByCategory(_):
            return Data()
        }
    }
}

