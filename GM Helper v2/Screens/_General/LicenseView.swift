//
//  LicenseView.swift
//  GM Helper Beta
//
//  Created by Tim W. Newton on 2/20/25.
//

import SwiftUI

struct LicenseView: View {
    private let content = """
======
This work includes material taken from the A5E System Reference Document (A5ESRD) by EN Publishing and available at A5ESRD.com, based on Level Up: Advanced 5th Edition, available at www.levelup5e.com. The A5ESRD is licensed under the Creative Commons Attribution 4.0 International License available at https://creativecommons.org/licenses/by/4.0/legalcode.

Level Up is a trademark of EN Publishing. The Powered By Level Up Compatibility Logo is used with permission. See www.levelup5e.com.

======
This work includes material taken from the System Reference Document 5.1 (“SRD 5.1”) by Wizards of the Coast LLC and available at https://dnd.wizards.com/resources/systems-reference-document. The SRD 5.1 is licensed under the Creative Commons Attribution 4.0 International License available at https://creativecommons.org/licenses/by/4.0/legalcode.
"""
    
    var body: some View {
        TextEditor(text: .constant(content))
            .padding()
            .navigationTitle(Text("Licenses"))
    }
}

#Preview {
    NavigationStack {
        LicenseView()
    }
}
