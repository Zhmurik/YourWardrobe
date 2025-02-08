import UIKit

import UIKit

extension UIFont {
    enum Oswald {
        enum Bold {
            static func size(size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Oswald.bold, size: size)!
            }
        }
        enum ExtraLight {
            static func size(size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Oswald.extraLight, size: size)!
            }
        }
        enum Light {
            static func size(size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Oswald.light, size: size)!
            }
        }
        enum Medium {
            static func size(size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Oswald.medium, size: size)!
            }
        }
        enum Regular {
            static func size(size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Oswald.regular, size: size)!
            }
        }
        enum SemiBold { // Capitalized for consistency
            static func size(size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Oswald.semiBold, size: size)!
            }
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

