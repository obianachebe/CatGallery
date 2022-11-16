// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  public enum CatFeed {
    /// There was a problem getting cats. Please try again.
    public static let errorMessageErrorGettingCats = Strings.tr("CatFeed", "error_message_error_getting_cats", fallback: "There was a problem getting cats. Please try again.")
    /// Error Getting Cats
    public static let errorTitleErrorGettingCats = Strings.tr("CatFeed", "error_title_error_getting_cats", fallback: "Error Getting Cats")
    /// Cat Feed
    public static let navTitleCatFeed = Strings.tr("CatFeed", "nav_title_cat_feed", fallback: "Cat Feed")
  }
  public enum Shared {
    /// Error
    public static let error = Strings.tr("Shared", "error", fallback: "Error")
    /// OK
    public static let ok = Strings.tr("Shared", "ok", fallback: "OK")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
