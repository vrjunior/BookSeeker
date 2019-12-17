import Foundation

enum DataStoreKey: String {
    case searchHistory
}

protocol UserDefaultsDataStoreProtocol {
    func set<Value>(value: Value, key: DataStoreKey)
    func get<Value>(_ key: DataStoreKey) -> Value?
    func remove(key: DataStoreKey)
}

final class UserDefaultsDataStore: UserDefaultsDataStoreProtocol {
    private let userDefaults: UserDefaultsProvider

    init(userDefaults: UserDefaultsProvider = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func set<Value>(value: Value, key: DataStoreKey) {
        userDefaults.set(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }

    func get<Value>(_ key: DataStoreKey) -> Value? {
        return userDefaults.value(forKey: key.rawValue) as? Value
    }


    func remove(key: DataStoreKey) {
        userDefaults.removeObject(forKey: key.rawValue)
        userDefaults.synchronize()
    }
}
