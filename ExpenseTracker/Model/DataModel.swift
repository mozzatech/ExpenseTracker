import UIKit
import SwiftUI


struct Account {
    private (set) var transactions: [Transaction]
    
    var balance: Double {
        var balance = 0.0
        for transaction in transactions
        {
            balance += transaction.signedAmount
        }
        return balance
    }
    
    mutating func add(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
    mutating func remove(intIndex: Int) {
        transactions.remove(at: intIndex)
    }
}
