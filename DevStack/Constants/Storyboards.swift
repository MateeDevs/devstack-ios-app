// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum LaunchScreenAlpha: StoryboardType {
    internal static let storyboardName = "LaunchScreen_Alpha"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreenAlpha.self)
  }
  internal enum LaunchScreenBeta: StoryboardType {
    internal static let storyboardName = "LaunchScreen_Beta"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreenBeta.self)
  }
  internal enum Login: StoryboardType {
    internal static let storyboardName = "Login"

    internal static let initialScene = InitialSceneType<LoginViewController>(storyboard: Login.self)
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

    internal static let initialScene = InitialSceneType<MainTabBarController>(storyboard: Main.self)
  }
  internal enum Profile: StoryboardType {
    internal static let storyboardName = "Profile"

    internal static let initialScene = InitialSceneType<ProfileViewController>(storyboard: Profile.self)
  }
  internal enum Users: StoryboardType {
    internal static let storyboardName = "Users"

    internal static let initialScene = InitialSceneType<UsersViewController>(storyboard: Users.self)
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

private final class BundleToken {}
