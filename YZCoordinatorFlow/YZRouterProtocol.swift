import UIKit

/// Protocol to Pop, Push, Dismiss etc. views
public protocol YZRouterProtocol: YZPresenterProtocol {
  // MARK: - Present

  /// Present view module with default animation
  func present(
    _ moduleTo: YZPresenterProtocol?,
    from moduleFrom: YZPresenterProtocol?
  )

  /// Present view module with animation
  func present(
    _ moduleTo: YZPresenterProtocol?,
    from moduleFrom: YZPresenterProtocol?,
    animated: Bool
  )

  /// Present view module with animation and completion
  func present(
    _ moduleTo: YZPresenterProtocol?,
    from moduleFrom: YZPresenterProtocol?,
    animated: Bool,
    completion: YZCompletion?
  )

  // MARK: - Dismiss

  /// Dismiss view module with default animation
  func dismiss(
    _ moduleFrom: YZPresenterProtocol?
  )

  /// Dismiss view module with animation
  func dismiss(
    _ moduleFrom: YZPresenterProtocol?,
    animated: Bool
  )

  /// Dismiss view module with animation and completion block
  func dismiss(
    _ moduleFrom: YZPresenterProtocol?,
    animated: Bool,
    completion: YZCompletion?
  )

  // MARK: - Push

  /// Push view module with default animation
  func push(
    _ moduleTo: YZPresenterProtocol?
  )

  /// Push view module with animation
  func push(
    _ moduleTo: YZPresenterProtocol?,
    animated: Bool
  )

  /// Push view module with animation and completion block
  func push(
    _ moduleTo: YZPresenterProtocol?,
    animated: Bool,
    completion: YZCompletion?
  )

  // MARK: - Pop

  /// Pop view modeue
  func pop(_ animated: Bool)

  /// Pop to root view module
  func popToRoot(_ animated: Bool)

  // MARK: - New stack

  /// Set view modules with default animation
  func setStack(_ modules: [YZPresenterProtocol])

  /// Set view modules
  func setStack(_ modules: [YZPresenterProtocol], animated: Bool)

  /// Set root view module
  func setRoot(_ module: YZPresenterProtocol?)

  /// Set root module and hide/show navigation bar
  func setRoot(_ module: YZPresenterProtocol?, hideBar: Bool)
}
