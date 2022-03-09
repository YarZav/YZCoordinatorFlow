import UIKit

/// Presenter protocol
public protocol YZPresenterProtocol {
  /// Current showing UINavigationController
  var navigationController: UINavigationController? { get }

  /// Current showing UIViewController
  var viewController: UIViewController? { get }
}

/// Default implimintation for Presenter protocol
extension YZPresenterProtocol {
  public var navigationController: UINavigationController? {
    return self as? UINavigationController
  }

  public var viewController: UIViewController? {
    return self as? UIViewController
  }
}
