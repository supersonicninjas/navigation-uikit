//
//  ContentView.swift
//  NavigationAppUIKit
//
//  Created by Mirza Učanbarlić on 24. 2. 2024..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var router: Router
    
    var body: some View {
        Form {
            Button("Present Sheet") {
                router.sheet(PresentedView())
            }
            Button("Present Full Screen") {
                router.present(PresentedView())
            }
            Button("Custom Present") {
                router.customPresent(PresentedView())
            }
            ForEach(Destination.allCases) { destination in
                Button(destination.title) {
                    router.push(destination)
                }
            }
        }
    }
}

struct PresentedView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "xmark")
                    .onTapGesture {
                        dismiss()
                    }
            }
            Spacer()
            Text("I am a presented view!")
            Spacer()
        }
        .padding(.all, 24)
    }
}

struct ScreenOneView: View {
    var body: some View {
        Text("Screen One")
            .foregroundStyle(Color.red)
    }
}

struct ScreenTwoView: View {
    var body: some View {
        Text("Screen Two")
            .foregroundStyle(Color.blue)
    }
}

struct ScreenThreeView: View {
    var body: some View {
        Text("Screen Three")
            .foregroundStyle(Color.green)
    }
}


#Preview {
    let router = Router(window: UIWindow())
    return ContentView()
        .environmentObject(router)
        
}
