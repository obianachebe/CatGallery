//
//  BuildConfig.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation

class BuildConfig {
    static var isDebug: Bool {
        #if DEBUG
        return true
        #endif

        return false
    }

    static var isSandbox: Bool {
        let path = Bundle.main.appStoreReceiptURL?.path
        return path?.contains("sanboxReceipt") == true
    }

    static var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    static var buildNumber: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }

    static var bundleId: String? {
        return Bundle.main.bundleIdentifier
    }

    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #endif

        return false
    }
}
