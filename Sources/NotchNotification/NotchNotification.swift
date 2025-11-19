// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftUI

@usableFromInline
let defaultInterval: TimeInterval = 2

public enum NotchNotification {
    public static func present(message: String, interval: TimeInterval = defaultInterval, onTap: (() -> Void)? = nil) {
        present(
            bodyView: Text(message),
            interval: interval,
            onTap: onTap
        )
    }

    public static func present(error: Error, interval: TimeInterval = defaultInterval, onTap: (() -> Void)? = nil) {
        present(error: error.localizedDescription, interval: interval, onTap: onTap)
    }

    public static func present(error: String, interval: TimeInterval = defaultInterval, onTap: (() -> Void)? = nil) {
        present(
            trailingView: Image(systemName: "xmark").foregroundStyle(.red),
            bodyView: Text(error),
            interval: interval,
            onTap: onTap
        )
    }

    public static func present(
        leadingView: some View = Image(systemName: "bell.fill"),
        trailingView: some View = EmptyView(),
        bodyView: some View = EmptyView().frame(width: 0, height: 0),
        interval: TimeInterval = 3,
        animated: Bool = true,
        onTap: (() -> Void)? = nil
    ) {
        let leadingView =
            leadingView
            .foregroundStyle(.white)
            .font(.system(.body, design: .rounded).weight(.bold))
        let trailingView =
            trailingView
            .foregroundStyle(.white)
            .font(.system(.body, design: .rounded).weight(.bold))
        let bodyView =
            bodyView
            .foregroundStyle(.white)
            .font(.system(.body, design: .rounded))

        guard
            let context = NotificationContext(
                headerLeadingView: leadingView,
                headerTrailingView: trailingView,
                bodyView: bodyView,
                animated: animated,
                onTap: onTap
            )
        else {
            return
        }

        context.open(forInterval: interval)
    }
}
