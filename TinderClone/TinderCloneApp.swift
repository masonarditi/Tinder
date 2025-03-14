import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct TinderCloneApp: App {
    // We'll store whether user is logged in or not
    @State private var isLoggedIn: Bool
    
    init() {
        // Configure Firebase
        FirebaseApp.configure()

        // Check if a user is already logged in from a previous session
        // If there's a currentUser, isLoggedIn = true
        if Auth.auth().currentUser != nil {
            _isLoggedIn = State(initialValue: true)
        } else {
            _isLoggedIn = State(initialValue: false)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                // If logged in, show HomeView
                ContentView(isLoggedIn: $isLoggedIn)
            } else {
                // If not logged in, show the Login/SignUp screen
                // Pass a binding so it can set isLoggedIn = true upon success
                LoginSignUpView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
