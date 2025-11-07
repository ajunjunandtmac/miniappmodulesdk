// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit
import SwiftUI

public protocol MiniAppModule {
    /// 模块唯一标识符
    static var moduleID: String { get }

    static func getInstance(withModuleId id: String) -> (any MiniAppModule)?
    /// UIKit入口
    func createInitialViewController() -> UIViewController?
    /// SwiftUI入口（可选）
    func createInitialView() -> AnyView?
}

public class MiniAppModuleCreator {
    static func createModule(moduleId: String, moduleName: String) -> (any MiniAppModule)? {
        guard let ClassType = NSClassFromString(moduleName) as? MiniAppModule.Type else {
            return nil
        }

        return ClassType.getInstance(withModuleId: moduleId)
    }
}
