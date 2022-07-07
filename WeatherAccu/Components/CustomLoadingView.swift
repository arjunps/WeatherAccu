//
//  CustomLoadingView.swift
//  WeatherAccu
//
//  Created by Arjun Personal on 07/07/22.
//

import SwiftUI

struct CustomLoadingView: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
