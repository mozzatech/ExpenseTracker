//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by HWorld on 10/15/22.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @EnvironmentObject private var accountVM: AccountViewModel
    
    var body: some View {
        VStack {
            HStack {
                // MARK: Header title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                // MARK: Header Link
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("Montlhy view")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            List{
                // MARK: Recent Transaction list (list of 5)
                ForEach(transactionListVM.items.prefix(5)/*.enumerated()*/, id: \.id/*\.element*/) { /*index,*/ transaction in
                    
                    TransactionRow(transaction: transaction)
                }.onDelete(perform: removeItem)
            }
            // MARK: to extend the list up to the borders add listStyle GroupedListStyle() or PlaintListStyle() after frame and edgesIgnoringSafeArea properties
            .frame(maxWidth: .infinity)
            .edgesIgnoringSafeArea(.all)
            .listStyle(PlainListStyle())
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.25), radius: 10, x: 0, y: 5)
    }
    
    
    func removeItem(at offsets: IndexSet) {
        transactionListVM.items.remove(atOffsets: offsets)
        let intIndex = offsets[offsets.startIndex]
        accountVM.remove(intIndex: intIndex)
    }
}





struct RecentTransactionList_Previews: PreviewProvider {
    // MARK: this is a trick to enforce a different value to the viewmodel for the preview
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.items = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            RecentTransactionList()
            RecentTransactionList()
                .preferredColorScheme(.dark)
        }
        // MARK: don't forget to pass the environment object to the preview, since it is a separate entity from the App
            .environmentObject(transactionListVM)
    }
}
