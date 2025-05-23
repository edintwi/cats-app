//
//  ErrorMessage.swift
//  cats-app
//
//  Created by Edson Brandon on 22/05/25.
//

import Foundation

enum CatError: String, Error {
    case invalidURL             = "Invalid URL."
    case unableToComplete       = "Unable to complete your request. Please check your network connection."
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data recived from the server is invalid. Please try again"
}
