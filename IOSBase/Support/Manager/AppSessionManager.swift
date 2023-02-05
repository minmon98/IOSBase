//
//  AppSessionManager.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation

class AppSessionManager {
    static let shared = AppSessionManager()
    private enum Keys {
        static let kTokenKey = "__token__"
        static let kUserInfoKey = "__user__"
    }
    
    var token: String? {
        get {
            return UserDefaults.standard.value(forKey: Keys.kTokenKey) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.kTokenKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    var user: UserInfo? {
        get {
            guard let data = UserDefaults.standard.value(forKey: Keys.kUserInfoKey) as? Data else { return nil }
            return try? JSONDecoder().decode(UserInfo.self, from: data)
        }
        set {
            UserDefaults.standard.set(try? JSONEncoder().encode(newValue), forKey: Keys.kUserInfoKey)
        }
    }
    
    func clear() {
        let domain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: domain ?? "")
        UserDefaults.standard.synchronize()
    }
}
