import Foundation

protocol UserDefaultsProvider {
    func set(_ value: Any?, forKey defaultName: String)
    func value(forKey key: String) -> Any?
    func bool(forKey key: String) -> Bool
    func dictionaryRepresentation() -> [String: Any]
    func removeObject(forKey defaultName: String)

    @discardableResult
    func synchronize() -> Bool
}

extension UserDefaults: UserDefaultsProvider {}
