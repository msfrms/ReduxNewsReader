//
//  Response.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 01.06.2021.
//

import Foundation

extension Error {
    public var noInternetConnection: Bool {
        let error = self as NSError

        let networkErrors = [NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet]

        if error.domain == NSURLErrorDomain && networkErrors.contains(error.code) {
            return true
        }
        return false
    }
}

public enum Response<T: Decodable> {
    case success(T?)
    case failed
    case cancelled
    case noInternetConnection
    case cannotFindHost

    init(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error as NSError? {
            switch (error.domain, error.code) {
            case (NSURLErrorDomain, NSURLErrorCancelled):
                self = .cancelled
            case (NSURLErrorDomain, NSURLErrorCannotFindHost):
                self = .cannotFindHost
                return
            default:
                guard !error.noInternetConnection else {
                    self = .noInternetConnection
                    return
                }
                self = .failed
            }
        }

        guard let response = response as? HTTPURLResponse else {
            self = .noInternetConnection
            return
        }

        guard let data = data else {
            preconditionFailure("Data need to be here")
        }
        
        if response.isSuccessful {
            do {
                if data.count > 0 {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    self = .success(result)
                }
                else {
                    self = .success(nil)
                }
            } catch  {
                self = .failed
            }
        }
        else {
            self = .failed
        }
    }
}
