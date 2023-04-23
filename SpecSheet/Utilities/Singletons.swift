//
//  Singletons.swift
//  fbt-terminal-ios
//
//  Created by Kraig Wastlund on 3/5/19.
//  Copyright © 2019 Fishbowl. All rights reserved.
//

import Foundation
import AVFoundation
import DBC
import CoreLocation
import MapKit

fileprivate let _userDefaultsApiTokenKey: String        = "apiToken"
fileprivate let _userDefaultsAuthEmailKey: String       = "authEmail"
fileprivate let _userDefaultsAuthIdKey: String          = "authId"

enum TimeOutSeconds {
    case never
    case fifteen
    case thirty
    case fourtyFive
    case sixty
}

class AuthenticatedSessionManager {
    
    static var loggingOut = false
    
    var authenticated: Bool {
        return (self.apiToken != "nil" && self.authEmail != nil && self.authId != "-1")
    }
    
    private (set) var apiToken: String? {
        get {
            return UserDefaults.standard.string(forKey: _userDefaultsApiTokenKey)
        }
        set(newApiToken) {
            UserDefaults.standard.set(newApiToken, forKey: _userDefaultsApiTokenKey)
        }
    }
    
    private (set) var authEmail: String? {
        get {
            return UserDefaults.standard.string(forKey: _userDefaultsAuthEmailKey)
        }
        set(newApiToken) {
            UserDefaults.standard.set(newApiToken, forKey: _userDefaultsAuthEmailKey)
        }
    }
    
    private (set) var authId: String? {
        get {
            if let id = UserDefaults.standard.string(forKey: _userDefaultsAuthIdKey) {
                return id
            }
            return "-1" // logged out
        }
        set(newAuthId) {
            UserDefaults.standard.set(newAuthId, forKey: _userDefaultsAuthIdKey)
        }
    }
    
    private static let sharedAuthenticatedSessionManager = AuthenticatedSessionManager() // lazy singleton
    
    class func shared() -> AuthenticatedSessionManager {
        return sharedAuthenticatedSessionManager
    }
    
    func activateLogOut() {
        AuthenticatedSessionManager.loggingOut = true
        apiToken = nil
        authEmail = nil
        authId = nil
    }
    
    func set(apiToken: String, authEmail: String, authId: String) {
        AuthenticatedSessionManager.loggingOut = false
        self.apiToken = apiToken
        self.authEmail = authEmail
        self.authId = authId
    }
}
