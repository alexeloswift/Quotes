//
//  QuotesTests.swift
//  QuotesTests
//
//  Created by Alexis Diaz on 10/31/22.
//

import XCTest
@testable import Quotes

final class QuotesTests: XCTestCase {

    private var viewmodel: QuotesViewmodel!

    override func setUp() {
        super.setUp()
        viewmodel = QuotesViewmodel()
    }

    func testStartQuote() {
        XCTAssertEqual(viewmodel.currentQuote.slideTransitionDelay, 3000)
    }

    func testupdateQuote() {
        // testing initial state of currentQuote

        XCTAssertEqual(viewmodel.currentSlide, 0)
        XCTAssertEqual(viewmodel.currentQuote.slideTransitionDelay, 3000)
        XCTAssertEqual(viewmodel.timeLeft, 0)

        viewmodel.updateQuote()

        // testing currentQuote after being updated

        /// These values are published to QuotesView
        XCTAssertEqual(viewmodel.currentQuote.slideTransitionDelay, 3000)
        XCTAssertEqual(viewmodel.timeLeft, 3)

        /// This value is in preparation to update quote again
        XCTAssertEqual(viewmodel.currentSlide, 1)
    }
}
