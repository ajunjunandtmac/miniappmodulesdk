// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import UIKit
import SwiftUI

public protocol MiniAppModule {
    /// 模块唯一标识符
    static var moduleID: String { get }
    /// UIKit入口
    func createInitialViewController(withParameters params: [String: Any]?) -> UIViewController?
    /// SwiftUI入口（可选）
    func createInitialView(withParameters params: [String: Any]?) -> AnyView?
}
