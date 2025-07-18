//
//  ProfileView.swift
//  TodoApp
//
//  Created by Waseem Abbas on 17/07/2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundStyle(Color.blue)
            Text("Your Profile")
                .font(.title)
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
