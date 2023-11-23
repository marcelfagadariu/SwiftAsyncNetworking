//
//  NetworkErrorTests.swift
//  
//
//  Created by Marcel on 23.11.2023.
//

import XCTest
@testable import NetworkError

final class NetworkErrorTests: XCTestCase {

    // MARK: - RequestError Tests

    func testInvalidURL() {
        let error = NetworkError.RequestError.invalidURL
        XCTAssertEqual(error, NetworkError.RequestError.invalidURL)
    }

    func testRequestFailed() {
        let error = NetworkError.RequestError.requestFailed
        XCTAssertEqual(error, NetworkError.RequestError.requestFailed)
    }

    func testInvalidResponse() {
        let error = NetworkError.RequestError.invalidResponse
        XCTAssertEqual(error, NetworkError.RequestError.invalidResponse)
    }

    func testInvalidData() {
        let error = NetworkError.RequestError.invalidData
        XCTAssertEqual(error, NetworkError.RequestError.invalidData)
    }

    func testServerError() {
        let statusCode = 500
        let error = NetworkError.RequestError.serverError(statusCode)
        XCTAssertEqual(error, NetworkError.RequestError.serverError(statusCode))
    }

    func testClientError() {
        let statusCode = 404
        let error = NetworkError.RequestError.clientError(statusCode)
        XCTAssertEqual(error, NetworkError.RequestError.clientError(statusCode))
    }

    func testUnknownError() {
        let error = NetworkError.RequestError.unknownError
        XCTAssertEqual(error, NetworkError.RequestError.unknownError)
    }

    // MARK: - DecodingError Tests

    func testDecodingFailed() {
        let underlyingError = NSError(domain: "TestDomain", code: 42, userInfo: nil)
        let decodingError = NetworkError.DecodingError.decodingFailed(underlyingError.localizedDescription)
        XCTAssertEqual(decodingError, NetworkError.DecodingError.decodingFailed(underlyingError.localizedDescription))
    }

    // MARK: - Combined Tests

    func testCombinedError() {
        let combinedError: Error = NetworkError.RequestError.invalidURL
        XCTAssertEqual(combinedError as? NetworkError.RequestError, NetworkError.RequestError.invalidURL)
        XCTAssertNil(combinedError as? NetworkError.DecodingError)
    }
}
