//
//  SwiftAsyncNetworking.swift
//
//
//  Created by Marcel on 23.11.2023.
//

import Foundation
import NetworkError
import Logger

open class SwiftAsyncNetworking {

    // MARK: - Properties

    private let session: URLSession
    private let decoder: JSONDecoder

    // MARK: - Init

    public init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }


    // MARK: - Generic Requests

    /// Asynchronously creates a basic URLRequest without a request body.
    ///
    /// - Parameters:
    ///   - url: The URL for the request.
    ///   - method: The HTTP method for the request.
    ///   - headers: The HTTP headers for the request.
    ///
    /// - Returns: An asynchronous `URLRequest` without a request body.
    ///
    /// - Throws: An error if there's an issue creating the request.
    open func request(url: URL, method: RestMethod, headers: [String: String]) async throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        headers.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }

    /// Asynchronously creates a URLRequest with the specified parameters.
    ///
    /// - Parameters:
    ///   - url: The URL for the request.
    ///   - method: The HTTP method for the request.
    ///   - headers: The HTTP headers for the request.
    ///   - body: The Encodable request body (optional). Default is `nil`.
    ///
    /// - Returns: An asynchronous `URLRequest` ready to be used for network requests.
    ///
    /// - Throws: An error if there's an issue creating the request or encoding the body.
    open func request(url: URL, method: RestMethod, headers: [String: String], body: Encodable? = nil) async throws -> URLRequest {
        var urlRequest = try await request(url: url, method: method, headers: headers)
        if let body = body {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }
        return urlRequest
    }

    // MARK: - REST Requests

    /// Asynchronously retrieves and decodes data from the specified URLRequest, handling potential errors.
    ///
    /// - Parameters:
    ///   - request: The URLRequest for which data needs to be retrieved and decoded.
    /// - Returns: A decoded object of the specified Response type.
    /// - Throws: An error of type NetworkError if the request, response, or decoding fails.
    open func data<Response: Decodable>(for request: URLRequest) async throws -> Response {
        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = (response as? HTTPURLResponse) else {
                throw NetworkError.RequestError.invalidResponse
            }

            if !(200..<300).contains(httpResponse.statusCode) {
                let errorDetails = String(data: data, encoding: .utf8) ?? "Unknown error"
                Logger.error("Request failed with status code \(httpResponse.statusCode)", details: errorDetails)
                throw NetworkError.RequestError.serverError(httpResponse.statusCode)
            }

            Logger.info("Request successful", details: "Status Code: \(httpResponse.statusCode)")
            Logger.info("Response: \n", details: String(data: data, encoding: .utf8) ?? "Unknown response")

            return try decoder.decode(Response.self, from: data)
        } catch let decodingError as DecodingError {
            throw NetworkError.DecodingError.decodingFailed(decodingError.localizedDescription)
        } catch {
            throw error
        }
    }
}

/// Extension providing convenience methods for making asynchronous network requests with SwiftAsyncNetworking.
public extension SwiftAsyncNetworking {
    /// Performs an asynchronous GET request to the specified URL with optional headers and a request body.
    ///
    /// - Parameters:
    ///   - url: The URL to make the GET request to.
    ///   - headers: A dictionary containing additional HTTP headers.
    ///   - body: An optional Encodable object to be included as the request body.
    /// - Returns: A decoded object of the specified Response type.
    /// - Throws: An error of type NetworkError if the request or decoding fails.
    func get<Response: Decodable>(url: URL, headers: [String: String]) async throws -> Response {
        try await data(for: try request(url: url, method: .get, headers: headers))
    }

    /// Performs an asynchronous POST request to the specified URL with optional headers and a request body.
    ///
    /// - Parameters:
    ///   - url: The URL to make the POST request to.
    ///   - headers: A dictionary containing additional HTTP headers.
    ///   - body: An optional Encodable object to be included as the request body.
    /// - Returns: A decoded object of the specified Response type.
    /// - Throws: An error of type NetworkError if the request or decoding fails.
    func post<Body: Encodable, Response: Decodable>(url: URL, headers: [String: String], body: Body? = nil) async throws -> Response {
        try await data(for: try request(url: url, method: .post, headers: headers, body: body))
    }

    /// Performs an asynchronous PUT request to the specified URL with optional headers and a request body.
    ///
    /// - Parameters:
    ///   - url: The URL to make the PUT request to.
    ///   - headers: A dictionary containing additional HTTP headers.
    ///   - body: An optional Encodable object to be included as the request body.
    /// - Returns: A decoded object of the specified Response type.
    /// - Throws: An error of type NetworkError if the request or decoding fails.
    func put<Body: Encodable, Response: Decodable>(url: URL, headers: [String: String], body: Body? = nil) async throws -> Response {
        try await data(for: try request(url: url, method: .put, headers: headers, body: body))
    }

    /// Performs an asynchronous PATCH request to the specified URL with optional headers and a request body.
    ///
    /// - Parameters:
    ///   - url: The URL to make the PATCH request to.
    ///   - headers: A dictionary containing additional HTTP headers.
    ///   - body: An optional Encodable object to be included as the request body.
    /// - Returns: A decoded object of the specified Response type.
    /// - Throws: An error of type NetworkError if the request or decoding fails.
    func patch<Body: Encodable, Response: Decodable>(url: URL, headers: [String: String], body: Body? = nil) async throws -> Response {
        try await data(for: try request(url: url, method: .patch, headers: headers, body: body))
    }

    /// Performs an asynchronous DELETE request to the specified URL with optional headers and a request body.
    ///
    /// - Parameters:
    ///   - url: The URL to make the DELETE request to.
    ///   - headers: A dictionary containing additional HTTP headers.
    ///   - body: An optional Encodable object to be included as the request body.
    /// - Returns: A decoded object of the specified Response type.
    /// - Throws: An error of type NetworkError if the request or decoding fails.
    func delete<Body: Encodable, Response: Decodable>(url: URL, headers: [String: String], body: Body? = nil) async throws -> Response {
        try await data(for: try request(url: url, method: .delete, headers: headers, body: body))
    }
}
