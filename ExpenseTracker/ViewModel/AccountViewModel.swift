//
//  AccountViewModel.swift
//  ExpenseTracker
//
//  Created by HWorld on 10/18/22.
//

import Foundation

class AccountViewModel : ObservableObject {
    @Published var account: Account = Account(transactions: TransactionListViewModel().items)
    
    func add(_ transaction: Transaction) {
        account.add(transaction)
    }
    
    func remove(intIndex: Int) {
        account.remove(intIndex: intIndex)
    }
}
