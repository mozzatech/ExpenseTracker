//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by HWorld on 10/15/22.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var transactions : TransactionListViewModel
    @EnvironmentObject private var accountVM: AccountViewModel
    
    
    //@State var category : Category
    @State private var addingNewTransaction = false
    
    var body: some View {
        NavigationView {
            
//            ScrollView {
//                VStack(alignment: .leading, spacing: 24) {
//                    // MARK: Title
//                    Text("Overview")
//                        .font(.title2)
//                        .bold()
//
//                    // MARK: Transaction list
//                    //RecentTransactionList()
//                }
//                .padding()
//                // MARK: to make all screen scrollable:
//                .frame(maxWidth: .infinity)
//            }
            VStack {
                Balance(amount: accountVM.account.balance)
                RecentTransactionList()
            }

//            List{
//                //Balance(amount: accountVM.accountSC.balance)
//                ForEach(transactions.items, id: \.id) { item in
//                    HStack
//                    {
//                        Text(String(item.categoryId))
//                        Spacer()
//                        Text(item.signedAmount.currencyFormat)
//                    }
//                }
//                .onDelete(perform: removeItem)
//            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarLeading)
                {
                    NavigationLink(destination: SettingsView(), label: {Image(systemName: "gearshape")})
                }
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing)
                {
                    Button(action: { addingNewTransaction = true }, label: {Image(systemName: "plus")})
                }
            }
            .sheet(isPresented: $addingNewTransaction){
                AddTransactionView(transactions: transactions, selectedCategory: .autoAndTransport)
            }
        }
        .navigationViewStyle(.stack)
        // the navigation "back" button on top bar would take the color from the system (usually it would be blue). That applies to views and controls. If that system color doesn't fit our design, we can change it with the accent color modifier to the ancestor navigation view. In this case we want all the views to inherit primary color
        .accentColor(.primary)
    }
    
    func removeItem(at offsets: IndexSet)
    {
        transactions.items.remove(atOffsets: offsets)
        
        //let intIndex = offsets[offsets.startIndex]
        //accountVM.remove(intIndex: intIndex)
    }
}


// MARK: - Balance
struct Balance: View
{
    let amount: Double
    var body: some View
    {
        HStack {
            Image(amount < 0 ? "SAD_PIG_001" : "HAPPY_PIG_001")
                .resizable()
                .scaledToFit()
            Spacer()
            
            VStack(alignment: .leading)
            {
                Text("Balance")
                    .font(.callout)
                    .bold()
                    .foregroundColor(.secondary)
                Text(amount.currencyFormat)
                    .font(.largeTitle)
                    .bold()
            }
            //.padding(.vertical)

        }
        .frame(maxHeight: 90)
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.items = transactionListPreviewData
        return transactionListVM
    }()
    
    static let accountVM: AccountViewModel = AccountViewModel()
    
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
        .environmentObject(accountVM)
    }
}
