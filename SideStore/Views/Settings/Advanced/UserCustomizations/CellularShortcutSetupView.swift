//
//  CellularShortcutSetupView.swift
//  Orbit
//

import SwiftUI
import UIKit

/// Walks the user through creating the two Shortcuts Cellular Refresh needs.
/// iOS doesn't let apps create shortcuts or check that they exist, so the user confirms this themselves.
struct CellularShortcutSetupView: View {
    static let confirmedKey = "cellularShortcutsSetupConfirmed"

    static var isConfirmed: Bool {
        get { UserDefaults.standard.bool(forKey: confirmedKey) }
        set { UserDefaults.standard.set(newValue, forKey: confirmedKey) }
    }

    let turnOffName: String
    let turnOnName: String
    let onConfirm: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Refreshing without Wi-Fi briefly turns cellular data off, then back on. Create these two shortcuts first. The names must match exactly.")
                }

                shortcutSection(name: turnOffName, action: "Turn Cellular Data Off")
                shortcutSection(name: turnOnName, action: "Turn Cellular Data On")

                Section {
                    SwiftUI.Button("I've Added Both Shortcuts") {
                        Self.isConfirmed = true
                        onConfirm()
                        dismiss()
                    }
                    .font(.headline)
                } footer: {
                    Text("Orbit can't check this for you. If a refresh fails, make sure both shortcuts exist and their names match.")
                }
            }
            .navigationTitle("Set Up Shortcuts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    SwiftUI.Button("Cancel") { dismiss() }
                }
            }
        }
    }

    private func shortcutSection(name: String, action: String) -> some View {
        Section(header: Text(name)) {
            Text("1. Copy the name\n2. Create a new shortcut and paste the name as its title\n3. Add the Set Cellular Data action: \(action)")
                .font(.subheadline)
            SwiftUI.Button("Copy Name") { UIPasteboard.general.string = name }
            SwiftUI.Button("Open Shortcuts") {
                if let url = URL(string: "shortcuts://create-shortcut") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}
