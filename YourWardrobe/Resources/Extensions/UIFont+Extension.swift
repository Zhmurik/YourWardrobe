import UIKit

extension UIFont {
    enum Oswald {
        static func bold(size: CGFloat) -> UIFont {
            return UIFont(name: Constants.Oswald.bold, size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
        }
        static func extraLight(size: CGFloat) -> UIFont {
            return UIFont(name: Constants.Oswald.extraLight, size: size) ?? UIFont.systemFont(ofSize: size, weight: .ultraLight)
        }
        static func light(size: CGFloat) -> UIFont {
            return UIFont(name: Constants.Oswald.light, size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
        }
        static func medium(size: CGFloat) -> UIFont {
            return UIFont(name: Constants.Oswald.medium, size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
        }
        static func regular(size: CGFloat) -> UIFont {
            return UIFont(name: Constants.Oswald.regular, size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
        }
        static func semiBold(size: CGFloat) -> UIFont {
            return UIFont(name: Constants.Oswald.semiBold, size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
        }
    }
}

private extension UIFont {
    enum Constants {
        enum Oswald {
            static let bold = "Oswald-Bold"
            static let extraLight = "Oswald-ExtraLight"
            static let light = "Oswald-Light"
            static let medium = "Oswald-Medium"
            static let regular = "Oswald-Regular"
            static let semiBold = "Oswald-SemiBold"
        }
    }
}
