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
    static let nameSpace: String?  = {
        let fullClassName = NSStringFromClass(MiniAppModuleCreator.self)
        guard let nameSpace = fullClassName.components(separatedBy: ".").first else {
            return nil
        }
        return nameSpace
    }()

    public static func createModule(moduleId: String, moduleName: String) -> (any MiniAppModule)? {
        guard let nameSpace else {
            return nil
        }

        guard let ClassType = NSClassFromString("\(nameSpace).\(moduleName)") as? MiniAppModule.Type else {
            return nil
        }

        return ClassType.getInstance(withModuleId: moduleId)
    }
}
