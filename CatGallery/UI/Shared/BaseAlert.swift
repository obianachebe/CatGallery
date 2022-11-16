//
//  BaseAlert.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation
import SwiftUI

/// A state object that holds all the state for an `Alert`
struct BaseAlert: Identifiable {
    var title: String

    var message: String?

    var primaryButton: Alert.Button?

    var secondaryButton: Alert.Button?

    var id: String = UUID().uuidString

    func buildView() -> Alert {
        if let message = message {
            if let primaryButton = primaryButton, let secondaryButton = secondaryButton {
                return Alert(
                    title: Text(title),
                    message: Text(message),
                    primaryButton: primaryButton,
                    secondaryButton: secondaryButton
                )
            } else if let button = primaryButton ?? secondaryButton {
                return Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: button
                )
            } else {
                return Alert(
                    title: Text(title),
                    message: Text(message)
                )
            }
        } else {
            if let primaryButton = primaryButton, let secondaryButton = secondaryButton {
                return Alert(
                    title: Text(title),
                    primaryButton: primaryButton,
                    secondaryButton: secondaryButton
                )
            } else if let button = primaryButton ?? secondaryButton {
                return Alert(
                    title: Text(title),
                    dismissButton: button
                )
            } else {
                return Alert(
                    title: Text(title)
                )
            }
        }
    }
}

extension BaseAlert {
    init(
        error: BaseError,
        primaryAction: Alert.Button? = .default(Text(Strings.Shared.ok), action: nil),
        secondaryButton: Alert.Button? = nil
    ) {
        self.title = error.title ?? Strings.Shared.error
        self.message = error.message
        self.primaryButton = primaryAction
        self.secondaryButton = secondaryButton
    }
}
