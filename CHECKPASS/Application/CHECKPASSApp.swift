//
//  CHECKPASSApp.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/21/23.
//

import SwiftUI

@main
struct CHECKPASSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(keyboardViewModel: KeyboardViewModel(),
                        signInViewModel: AppDI.shared().getSignInViewModel())
        }
    }
}
