//
//  RestMethod.swift
//
//
//  Created by Marcel on 23.11.2023.
//

// MARK: - HTTP Method

public enum RestMethod: String, CaseIterable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
