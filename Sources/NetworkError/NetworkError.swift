//
//  NetworkError.swift
//
//
//  Created by Marcel on 23.11.2023.
//

/// Enum representing errors that can occur during network operations.
public enum NetworkError: Error {

    /// Enum representing errors that occur during the request phase.
    public enum RequestError: Error, Equatable {
        /// The URL used for the request is invalid.
        case invalidURL
        /// The network request failed.
        case requestFailed
        /// The response from the server is invalid.
        case invalidResponse
        /// The data received from the server is invalid.
        case invalidData
        /// A server error occurred with the specified status code.
        case serverError(Int)
        /// A client error occurred with the specified status code.
        case clientError(Int)
        /// An unknown error occurred during the request phase.
        case unknownError
    }

    /// Enum representing errors that occur during the decoding phase.
    public enum DecodingError: Error, Equatable {
        /// Decoding of the response data failed with the associated error.
        case decodingFailed(String)
    }
}
