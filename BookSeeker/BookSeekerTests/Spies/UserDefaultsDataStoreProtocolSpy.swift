@testable import BookSeeker

final class UserDefaultsDataStoreProtocolSpy: UserDefaultsDataStoreProtocol {
    var getValueToBeReturned: Any?
    
    private(set) var setCalled = false
    private(set) var getCalled = false
    private(set) var valuePassed: Any?
    private(set) var keyPassed: DataStoreKey?
    
    func set<Value>(value: Value, key: DataStoreKey) {
        setCalled = true
        valuePassed = value
        keyPassed = key
    }
    
    func get<Value>(_ key: DataStoreKey) -> Value? {
        getCalled = true
        keyPassed = key
        return getValueToBeReturned as? Value
    }
    
    func remove(key: DataStoreKey) {}
}
