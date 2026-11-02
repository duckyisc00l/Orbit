//
//  OrbitAppearance.swift
//  Orbit
//

import UIKit

/// App-wide look shared by the UIKit screens. Needs proper testing on a device.
enum OrbitAppearance {
    static let mutedText = UIColor(red: 0.62, green: 0.63, blue: 0.72, alpha: 1)

    static func apply() {
        UITabBar.appearance().unselectedItemTintColor = mutedText

        let navigationBar = UINavigationBarAppearance()
        navigationBar.configureWithDefaultBackground()
        navigationBar.titleTextAttributes = [
            .font: roundedFont(size: 17, weight: .semibold),
            .foregroundColor: UIColor.white
        ]
        navigationBar.largeTitleTextAttributes = [
            .font: roundedFont(size: 34, weight: .bold),
            .foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().standardAppearance = navigationBar
    }

    private static func roundedFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        guard let descriptor = font.fontDescriptor.withDesign(.rounded) else { return font }
        return UIFont(descriptor: descriptor, size: size)
    }
}
