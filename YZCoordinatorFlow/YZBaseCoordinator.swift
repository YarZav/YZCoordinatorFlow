/// Default completion code block for coordinator flow
public typealias YZCompletion = () -> Void

// MARK: - YZBaseCoordinator


open class YZBaseCoordinator {
  /// Children coordinators
  public lazy var childCoordinators: [YZCoordinatorProtocol] = []

  /// Default init
  public init() { }
}

// MARK: - Publics

public extension YZBaseCoordinator {
  /// Add unique coordinator
  func addDependency(_ coordinator: YZCoordinatorProtocol) {
    if !childCoordinators.contains(where: { $0 === coordinator }) {
      childCoordinators.append(coordinator)
    }
  }

  /// Remove coordinator
  func removeDependency(_ coordinator: YZCoordinatorProtocol?) {
    guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
    childCoordinators.removeAll { $0 === coordinator }
  }
}
