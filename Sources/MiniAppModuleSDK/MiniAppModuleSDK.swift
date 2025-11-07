// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit
import SwiftUI

public protocol MiniAppModule {
    /// mini app id
    static var miniAppId: String { get }

    static func getInstance(withMiniAppId id: String) -> (any MiniAppModule)?
    /// UIKit entrance
    func createInitialViewController() -> UIViewController?
    /// SwiftUI entrance
    func createInitialView() -> AnyView?
}

public struct MiniAppInfo {
    let miniAppId: String
    let libraryName: String

    public init(miniAppId: String, libraryName: String) {
        self.miniAppId = miniAppId
        self.libraryName = libraryName
    }
}

public final class MiniAppModuleManager: @unchecked Sendable {
    public static let shared = MiniAppModuleManager()
    private init() {}

    public func getViewController(with info: MiniAppInfo) -> UIViewController? {
        let moduleInstance = getModuleInstance(with: info)
        return moduleInstance?.createInitialViewController()
    }

    public func getSwiftView(with info: MiniAppInfo) -> AnyView? {
        let moduleInstance = getModuleInstance(with: info)
        return moduleInstance?.createInitialView()
    }

    public func isModuleActive(with module: MiniAppInfo) -> Bool {
        return getModuleInstance(with: module) != nil
    }

    private func getModuleInstance(with info: MiniAppInfo) -> (any MiniAppModule)? {
        let miniAppId = info.miniAppId
        let libraryName = info.libraryName
        return MiniAppModuleCreator.createModule(miniAppId: miniAppId, libraryName: libraryName)
    }
}

final class MiniAppModuleCreator {

    /// Create mini app module instance by reflection
    /// - Parameters:
    ///   - moduleId: the mini app ID
    ///   - libraryName: the mini app library name
    /// - Returns: the instance of the mini app module
    static func createModule(miniAppId: String, libraryName: String) -> (any MiniAppModule)? {
        let nameSpace = libraryName
        guard let ClassType = NSClassFromString("\(nameSpace).\(libraryName)") as? MiniAppModule.Type else {
            return nil
        }

        return ClassType.getInstance(withMiniAppId: miniAppId)
    }
}
