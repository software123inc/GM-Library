//
//  DetailsTextView.swift
//  GM Helper v2
//
//  Created by Tim W. Newton on 2/24/25.
//

import SwiftUI

struct DetailsTextView: View {
    var heading: String?
    var content: String?
    
    var body: some View {
        VStack(alignment:.leading, spacing: 2) {
            if let heading {
                HStack {
                    Text(heading)
                        .font(.headline)
                    Spacer()
                }
                A5eHorizontalBorderView()
            }
            if let content {
                Text(content)
            }
            else {
                EmptyView()
            }
        }
    }
}
