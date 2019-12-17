import Foundation

protocol PresentableError {
    func getLocalizedMessage(from error: Error) -> String
}

extension PresentableError {
    func getLocalizedMessage(from error: Error) -> String {
        return Localization.GenericError.LocalizedMessage.text
    }
}
