import Foundation
import Collections
import SwiftUI


/// it' s a best practice to create a typealias for a datatype in order to make it reausable and easy to refer to
/// the following typealis is a dictionary
typealias TransactionGroup = Dictionary<String, [Transaction]>


final class TransactionListViewModel: ObservableObject {
    
    // MARK: the property wrapper @Published is responsible for sending notification to the subscribers whenever its value has changed
    @Published var items: [Transaction] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    
    // MARK: the purpose of the initializer is to set all non-optional values when an instance of this class is created
    // MARK: it is the same as C# CONSTRUCTOR
    // MARK: there exist also overloaded init functions, e.g: CONVENIENCE INIT
    init() {
        // Read data from the user defaults for the key Items. It's "optional", namely it might not exist
        if let savedItems = UserDefaults.standard.data(forKey: "items") {
            // if we were able to read something, attempt to decode it;
            // as an array of Transaction, convert data into a particular type of Swift.
            // what does .self stand for? It means we want to refer to THAT particular array of TransactionItem, not a new one
            if let decodedItems = try? JSONDecoder().decode([Transaction].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []

    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        // we should ensure the transaction array is not empty before proceeding
        guard !items.isEmpty else { return [:] } // [:] means empty dictionary
        
        let groupedTransactions = TransactionGroup(grouping: items, by: { $0.month })
        //let groupedTransactionsSorted = groupedTransactions.sorted(by: { $0.0 < $1.0 })
        
        return groupedTransactions
    }
    
    
//    func GLBremoveItem(at offsets: IndexSet, AVM: AccountViewModel) {
//        self.items.remove(atOffsets: offsets)
//        let intIndex = offsets[offsets.startIndex]
//        AVM.remove(intIndex: intIndex)
//    }
    
//    func GLBremoveItem(at offsets: IndexSet, closure01: ([Transaction], AccountViewModel) -> Void) {
//        closure01(items, accountVM)
//    }
}
