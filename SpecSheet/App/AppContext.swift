////
////  AppContext.swift
////  Excalibur
////
////  Created by Michael Wells on 12/7/22.
////
//
//import Foundation
//import SwiftUI
//
//enum AuthState {
//    case unauthenticated
//    case authenticated(AuthCredentials)
//}
//
//class AppContext: ObservableObject {
//
//    // MARK: Properties
//
//    var server: Server
//
//    static var rest = AppContext(server: RESTServer())
//
//    // MARK: Initializers
//
//    private init(server: Server) {
//        self.server = server
//    }
//
//    // MARK: Error
//
//    @Published var error: Error? {
//        didSet {
//            errorDetails = errorDetails(for: error)
//        }
//    }
//
//    var errorDetails: ErrorDetails = .none
//
//    // MARK: Authentication
//
//    @Published var authState: AuthState = .unauthenticated {
//        didSet {
//            if case .authenticated = authState {
//                loggedOut = false
//            } else {
//                loggedOut = true
//            }
//        }
//    }
//
//    @Published var loggedOut: Bool = true
//
//    @Published var useSandboxData: Bool = AppSettings.useSandbox {
//        didSet {
//            AppSettings.setUseSandbox(useSandboxData)
//        }
//    }
//
//    // Don't use this. It's an internal implementation detail
//    @Published var _appEnvironment: AppEnvironment = .production {
//        willSet (newValue) {
//            server.setEnvironment(newValue)
//        }
//    }
//
//}
//
//// MARK: - Error
//
//extension AppContext {
//
//    struct ErrorDetails {
//        static let none = ErrorDetails(title: "TITLE", message: "MESSAGE", errorType: "ERROR_TYPE")
//
//        let title: String
//        let message: String
//        let errorType: String
//    }
//
//    private func errorDetails(for outerError: Error?) -> ErrorDetails {
//        let error = outerError ?? RuntimeError.unresolved
//
//        let errorType = "\(type(of: error))"
//
//        if let jsonError = error as? JSONError {
//            // This is a JSON encode/decode error so there is
//            // context that can explain why the error occurred.
//            return ErrorDetails(
//                title: jsonError.title,
//                message: jsonError.localizedDescription,
//                errorType: errorType
//            )
//        }
//
//        guard let httpError = error as? HTTPError else {
//            // This isn't an HTTP so don't try to infer any further
//            // information, just report the basic details.
//            return ErrorDetails(
//                title: "Error",
//                message: error.localizedDescription,
//                errorType: errorType
//            )
//        }
//
//        // Instead of using the default system-provided error messages,
//        // look into the NSError and try to provide a more suitable
//        // message to display to the user.
//
//        if
//            let nsError = httpError.error as? NSError,
//            let nsUnderlyingError = nsError.userInfo[NSUnderlyingErrorKey] as? NSError,
//            nsUnderlyingError.domain == (kCFErrorDomainCFNetwork as String)
//
//        {
//            switch nsUnderlyingError.code {
//            case NSURLErrorTimedOut:
//                return ErrorDetails(
//                    title: "Request Timed Out",
//                    message: "The request failed. Please try again. If the problem persists, contact support.",
//                    errorType: errorType
//                )
//            default:
//                break
//            }
//        }
//
//        // If the error doesn't contain any received data, there is
//        // nothing more to do. Just report it with the system provided
//        // error message.
//
//        guard let data = httpError.data else {
//            return ErrorDetails(
//                title: httpError.status?.description ?? "Error",
//                message: error.localizedDescription,
//                errorType: errorType
//            )
//        }
//
//        // If data was received, try to decode a structured server error.
//
//        if let apiError: ServerError = try? JSON.decode(data) {
//            return ErrorDetails(
//                title: apiError.error,
//                message: apiError.message,
//                errorType: errorType
//            )
//        }
//
//        // An HTTP error was received, but there isn't anything
//
//        return ErrorDetails(
//            title: httpError.status?.description ?? "Error",
//            message: error.localizedDescription,
//            errorType: errorType
//        )
//    }
//
//}
