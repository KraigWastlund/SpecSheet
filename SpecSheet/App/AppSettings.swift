////
////  AppSettings.swift
////  Excalibur
////
////  Created by Michael Wells on 3/29/23.
////
//
//import Foundation
//
//enum AppSettings {
//    // Notes:
//    // UserDefaults has a bug in simulator where data doesn't always persist between app sessions.
//    // I have spent a couple good hours researching and have not found the solution.
//    // I am suspicious that it might have something to do with having multiple targets (i.e. Go/Drive)
//    // I have found these resources and still haven't been able to remedy the issue:
//    // https://stackoverflow.com/questions/41892361/userdefaults-not-saving-consistently-when-using-xcode-simulator
//    // https://stackoverflow.com/questions/69160191/userdefault-is-not-working-with-m1-chip-macbook-air-and-xcode-simulator-in-swift
//    // https://jameshaville.com/appstorage-interesting/
//    //
//    // Added note: I have (as of yet) NOT been able to reproduce this on device.  I do not believe it is a risk to our end users.
//        
//    private static let userDefaults = UserDefaults(suiteName: "group.com.fishbowl.drive")!
//    
//    private static let _userDefaultsKeyUsername         = "fishbowl.drive.username"
//    private static let _userDefaultsKeyPassword         = "fishbowl.drive.password"
//    private static let _userDefaultsKeyAuthToken        = "fishbowl.drive.auth_token"
//    private static let _userDefaultsKeyRememberUsername = "fishbowl.drive.remember_username"
//    private static let _userDefaultsKeyUseSandbox       = "fishbowl.drive.use_sandbox_data"
//    private static let _userDefaultsKeyLastRootModule   = "fishbowl.drive.last_root_module"
//    private static let _userDefaultsKeyRecentSearches   = "fishbowl.drive.recent_searches"
//        
//    // MARK: - LOGIN
//    
//    static let loggedInNotification = NSNotification.Name(rawValue: "loggedInNotification")
//    static let publisherForLogggedInNotification = NotificationCenter.default.publisher(for: AppSettings.loggedInNotification)
//    
//    static var isLoggedIn: Bool {
//        AppSettings.authToken != nil
//    }
//    
//    static func authenticate(username name: String, authToken token: String) {
//        AppSettings.username = name
//        AppSettings.authToken = token
//    }
//    
//    private(set) static var username: String? {
//        get {
//            AppSettings.userDefaults.string(forKey: _userDefaultsKeyUsername)
//        }
//        set(newValue) {
//            AppSettings.userDefaults.set(newValue, forKey: _userDefaultsKeyUsername)
//        }
//    }
//        
//    // TODO: REMOVE BEFORE PUBLISHING TO PRODUCTION!!!
//    /// This should be removed before deploying to production.
//    /// Temporarily here for developers sanity while building MVP
//    /// Hoping we move to a "only invalidate JWT every few months" protocol
//    /// That way we don't have to "log in" each session.
//    /// - Kraig
//    private(set) static var password: String? {
//        get {
//            AppSettings.userDefaults.string(forKey: _userDefaultsKeyPassword)
//        }
//        set(newValue) {
//            AppSettings.userDefaults.set(newValue, forKey: _userDefaultsKeyPassword)
//        }
//    }
//    
//    // TODO: TEMPORARY - See line 49
//    static func setPassword(_ passwordString: String) {
//        AppSettings.password = passwordString
//    }
//    
//    private(set) static var authToken: String? {
//        get {
//            AppSettings.userDefaults.string(forKey: _userDefaultsKeyAuthToken)
//        }
//        set(newValue) {
//            AppSettings.userDefaults.set(newValue, forKey: _userDefaultsKeyAuthToken)
//            let loggedIn = newValue != nil && !newValue!.isEmpty
//            NotificationCenter.default.post(name: loggedInNotification, object: loggedIn)
//        }
//    }
//        
//    private(set) static var rememberUsername: Bool {
//        get {
//            AppSettings.userDefaults.bool(forKey: _userDefaultsKeyRememberUsername)
//        }
//        set(newValue) {
//            AppSettings.userDefaults.set(newValue, forKey: _userDefaultsKeyRememberUsername)
//        }
//    }
//    
//    static func setRememberUsername(_ bool: Bool) {
//        AppSettings.rememberUsername = bool
//    }
//        
//    private(set) static var useSandbox: Bool {
//        get {
//            AppSettings.userDefaults.bool(forKey: _userDefaultsKeyUseSandbox)
//        }
//        set(newValue) {
//            AppSettings.userDefaults.set(newValue, forKey: _userDefaultsKeyUseSandbox)
//        }
//    }
//    
//    static func setUseSandbox(_ bool: Bool) {
//        AppSettings.useSandbox = bool
//    }
//    
//    static func logOut() {
//        userDefaults.removeObject(forKey: _userDefaultsKeyUsername)
//        userDefaults.removeObject(forKey: _userDefaultsKeyPassword)
//        userDefaults.removeObject(forKey: _userDefaultsKeyAuthToken)
//        userDefaults.removeObject(forKey: _userDefaultsKeyRememberUsername)
//        userDefaults.removeObject(forKey: _userDefaultsKeyUseSandbox)
//        setLastRootModule(.placeholder)
//    }
//    
//    // MARK: - ROOT MODULE
//
//    private(set) static var lastRootModule: RootModule {
//        get {
//            let text = AppSettings.userDefaults.string(forKey: _userDefaultsKeyLastRootModule) ?? RootModule.placeholder.rawValue
//            guard let rootModule = RootModule(rawValue: text), rootModule != .placeholder else { return .items }
//            return rootModule
//        }
//        set(newValue) {
//            AppSettings.userDefaults.set(newValue.rawValue, forKey: _userDefaultsKeyLastRootModule)
//        }
//    }
//
//    static func setLastRootModule(_ rootModule: RootModule) {
//        guard rootModule != .placeholder else { return }
//        AppSettings.lastRootModule = rootModule
//    }
//        
//    // MARK: - RECENT SEARCHE
//     
//     private static let maxSavedSearches = 10
//     
//     private static func recentSearchKey(forType type: PlatformModelType) -> String {
//         _userDefaultsKeyRecentSearches + ":" + type.rawValue.lowercased()
//     }
//     
//     static func recentSearches(forType type: PlatformModelType) -> [RecentSearch] {
//         recentSearches(forKey: recentSearchKey(forType: type))
//     }
//     
//     private static func recentSearches(forKey key: String) -> [RecentSearch] {
//         guard let data = userDefaults.data(forKey: key) else {
//             return []
//         }
//         
//         do {
//             return try JSON.decode(data)
//         } catch let error {
//             Log.error(error)
//         }
//         
//         return []
//     }
//     
//     static func addRecentSearch(_ search: RecentSearch) {
//         let key = recentSearchKey(forType: search.modelType)
//         
//         var searches = recentSearches(forKey: key)
//         
//         if let index = searches.firstIndex(where: { $0.text.lowercased() == search.text.lowercased() }) {
//             searches[index] = search
//         } else {
//             searches.insert(search, at: 0)
//         }
//         
//         searches.sort(by: { lhs, rhs in
//             lhs.createdAt > rhs.createdAt
//         })
//         
//         do {
//             let data = try JSON.encode(Array(searches.prefix(maxSavedSearches)))
//             userDefaults.setValue(data, forKey: key)
//         } catch let error {
//             Log.error(error)
//         }
//     }
//     
//     @discardableResult
//     static func removingRecentSearch(_ search: RecentSearch) -> [RecentSearch] {
//         let key = recentSearchKey(forType: search.modelType)
//         
//         let searches = recentSearches(forKey: key).filter({ $0.id != search.id })
//         
//         if searches.isEmpty {
//             userDefaults.removeObject(forKey: key)
//             return []
//         }
//         
//         do {
//             let data = try JSON.encode(searches)
//             userDefaults.setValue(data, forKey: key)
//         } catch let error {
//             Log.error(error)
//         }
//         
//         return searches
//     }
//     
//     static func removeAllRecentSearches(forType type: PlatformModelType) {
//         let key = recentSearchKey(forType: type)
//         userDefaults.removeObject(forKey: key)
//     }
//
//}
