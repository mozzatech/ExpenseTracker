import SwiftUI

@main
struct ExpenseTrackerApp: App {
    // MARK: ViewModel initialization when the App starts
    // parentheses at the end means we want to initialize the object
    var transactionListVM = TransactionListViewModel()
    var accountVM = AccountViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM) ///by doing so, all children of this View can access the object
                .environmentObject(accountVM)
        }
    }
}
