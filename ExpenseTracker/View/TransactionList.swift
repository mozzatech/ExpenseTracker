//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by HWorld on 10/22/22. 
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @EnvironmentObject private var accountVM: AccountViewModel
    
    var body: some View {
        VStack{
            List {
                // MARK: transaction Groups
                ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key) {
                    month, items in
                    Section {
                        // MARK: Transaction List
                        ForEach(items) { item in
                            TransactionRow(transaction: item)
                        }
                    } header: {
                        // MARK: Transaction Month as label
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
                .onDelete(perform: removeItem)
            }
            
            // MARK: to extend the list up to the borders add listStyle GroupedListStyle() or PlaintListStyle() after frame and edgesIgnoringSafeArea properties
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.horizontal)
            .listStyle(GroupedListStyle())
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        transactionListVM.items.remove(atOffsets: offsets)
        let intIndex = offsets[offsets.startIndex]
        accountVM.remove(intIndex: intIndex)
    }
}

struct TransactionList_Previews: PreviewProvider {
    // MARK: this is a trick to enforce a different value to the viewmodel for the preview
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.items = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            TransactionList()
            TransactionList()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
