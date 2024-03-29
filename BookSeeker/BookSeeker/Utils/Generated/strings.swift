// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum Localization {

  internal enum GenericError {
    internal enum LocalizedMessage {
      /// Algo deu errado.
      internal static let text = Localization.tr("Localizable", "GenericError.LocalizedMessage.Text")
    }
  }

  internal enum SearchViewController {
    internal enum NavigationItem {
      /// Busca
      internal static let title = Localization.tr("Localizable", "SearchViewController.NavigationItem.Title")
    }
    internal enum SearchBar {
      /// Busque por livros
      internal static let placeholder = Localization.tr("Localizable", "SearchViewController.SearchBar.Placeholder")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
