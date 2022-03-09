import UIKit

/// Router completion block
public typealias YZRouterCompletions = [UIViewController: YZCompletion]

// MARK: - Router

final public class RouterImp: NSObject {
  /// Root controller
  fileprivate var rootController: UINavigationController?

  /// Completion code block
  fileprivate var completions: YZRouterCompletions

  /// Init with 'rootController'
  ///
  /// - Parameters:
  ///       rootController: root UInavigationController
  public init(rootController: UINavigationController?) {
    self.rootController = rootController
    completions = [:]
  }
}

// MARK: - Privates

private extension RouterImp {
  private func performCompletionBlock(for controller: UIViewController) {
    guard let completion = completions[controller] else { return }

    completion()
    completions.removeValue(forKey: controller)
  }
}

// MARK: -

public extension RouterImp {
  /// Get current navigation controller
  var navigationController: UINavigationController? {
    return rootController
  }

  /// Get current view controller
  var viewController: UIViewController? {
    return rootController?.viewControllers.last
  }
}

// MARK: - Router

extension RouterImp: YZRouterProtocol {
  // MARK: - Present

  public func present(
    _ moduleTo: YZPresenterProtocol?,
    from moduleFrom: YZPresenterProtocol?
  ) {
    present(moduleTo, from: moduleFrom, animated: true)
  }

  public func present(
    _ moduleTo: YZPresenterProtocol?,
    from moduleFrom: YZPresenterProtocol?,
    animated: Bool
  ) {
    present(moduleTo, from: moduleFrom, animated: animated, completion: nil)
  }

  public func present(
    _ moduleTo: YZPresenterProtocol?,
    from moduleFrom: YZPresenterProtocol?,
    animated: Bool,
    completion: YZCompletion?
  ) {
    guard let controller = moduleTo?.viewController else { return }
    guard let fromController = moduleFrom?.viewController else { return }
    if #available(iOS 13.0, *) {
      controller.isModalInPresentation = true
      controller.modalPresentationStyle = .fullScreen
    }
    fromController.present(controller, animated: animated, completion: completion)
  }

  // MARK: - Dismiss

  public func dismiss(_ moduleFrom: YZPresenterProtocol?) {
    dismiss(moduleFrom, animated: true)
  }
  
  public func dismiss(_ moduleFrom: YZPresenterProtocol?, animated: Bool) {
    dismiss(moduleFrom, animated: animated, completion: nil)
  }
  
  public func dismiss(_ moduleFrom: YZPresenterProtocol?, animated: Bool, completion: YZCompletion?) {
    guard let fromController = moduleFrom?.viewController else { return }
    fromController.dismiss(animated: animated, completion: completion)
  }

  // MARK: - Push

  public func push(
    _ moduleTo: YZPresenterProtocol?
  ) {
    push(moduleTo, animated: true)
  }

  /// Push view module with animation
  public func push(
    _ moduleTo: YZPresenterProtocol?,
    animated: Bool
  ) {
    push(moduleTo, animated: animated, completion: nil)
  }

  /// Push view module with animation and completion block
  public func push(
    _ moduleTo: YZPresenterProtocol?,
    animated: Bool,
    completion: YZCompletion?
  ) {
    guard let controller = moduleTo?.viewController else { return }
    if let completion = completion {
      completions[controller] = completion
    }
    rootController?.pushViewController(controller, animated: animated)
  }

  // MARK: - Pop

  /// Pop to previous view
  public func pop(_ animated: Bool) {
    if let controller = rootController?.popViewController(animated: animated) {
      performCompletionBlock(for: controller)
    }
  }

  public func popToRoot(_ animated: Bool) {
    if let controllers = rootController?.popToRootViewController(animated: animated) {
      controllers.forEach { performCompletionBlock(for: $0) }
    }
  }

  // MARK: - New stack

  public func setStack(_ modules: [YZPresenterProtocol]) {
    setStack(modules, animated: true)
  }

  public func setStack(_ modules: [YZPresenterProtocol], animated: Bool) {
    let controllers: [UIViewController]? = modules.filter { $0 is UIViewController } as? [UIViewController]
    guard let viewControllers = controllers else { return }
    rootController?.setViewControllers(viewControllers, animated: animated)
  }

  public func setRoot(_ module: YZPresenterProtocol?) {
    setRoot(module, hideBar: false)
  }

  public func setRoot(_ module: YZPresenterProtocol?, hideBar: Bool) {
    guard let controller = module?.viewController else { return }
    rootController?.setViewControllers([controller], animated: false)
    rootController?.isNavigationBarHidden = hideBar
  }
}
