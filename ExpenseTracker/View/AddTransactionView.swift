//
//  AddTransactionView.swift
//  ExpenseTracker
//
//  Created by HWorld on 10/16/22.
//

import SwiftUI

struct AddTransactionView: View {
    
    /// with this declaration we mean we want to share the object already created in theparent view (ContentView)
    @ObservedObject var transactions: TransactionListViewModel
    
    @EnvironmentObject private var accountVM: AccountViewModel
    
    /// adding the following environment variable to make automatic dismiss of the sheet when "Save" button is pressed;
    /// we don't need to specify a type here, Swift can know what type it is based on the environment key we are trying to read
    @Environment(\.dismiss) var dismiss
    
    @State private var popoverIsShowing = false
    
    @State var selectedCategory: Category
    @State private var selection: String?
    @State private var tran_amount = ""
    @State private var tran_date = Date()
    @State private var tran_note = ""
    
    
    @State private var tran_isExp = true
    
    
    var body: some View {
        NavigationView{
            VStack{
                ToggleView(isExpense: $tran_isExp)
                Form{
                    Picker("Category", selection: $selectedCategory) {
                        //CategorySelection(selectedCatergory: $selectedCategory)
                                //.buttonStyle(PlainButtonStyle())
                        List(selection: $selection) {
                            ForEach(tran_isExp ? Category.expenseCategories : Category.incomeCategories, id: \.self) { item in
                                HStack {
                                    Text(item.name)
                                }
                            }
                        }
                    }
                    Amount(amount: $tran_amount)
                    DatePicker("Date", selection: $tran_date, displayedComponents: [.date])
                    ZStack (alignment: .leading) {
                        Text("Note").opacity(tran_note == "" ? 0.5 : 0)
                        TextEditor(text: $tran_note)
                            .padding(.leading, -3.0)
                            .lineLimit(5)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            .padding(.top)
            //.navigationTitle("Add new transaction")
            .navigationBarTitle("New transaction", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") { dismiss() },
                                trailing: Button("Save") {
                                addTransaction()
                                dismiss()
                                })
        }
        .popover(isPresented: $popoverIsShowing) {
            Text("Please insert a valid amount")
            Button("dismiss") {
                popoverIsShowing = false
            }
        }
    }
}

private extension AddTransactionView {
    
    func addTransaction() {
        if Double(tran_amount) ?? 0.0 > 0.0 {
            let transaction = Transaction(date: tran_date.formatted(date: .abbreviated, time: .omitted), amount: Double(tran_amount) ?? 0.0, type: "debit", categoryId: selectedCategory.id, categoryName: selectedCategory.name, note: tran_note, isExpense: selectedCategory.isExpense, isEdited: false)
        
            transactions.items.append(transaction)
            accountVM.add(transaction)
        }
        else { popoverIsShowing = true }
    }
}

// MARK: Toggle
struct ToggleView: View {
    
    @Binding var isExpense : Bool
    
    let three_columns = [
        GridItem(.flexible()),
        GridItem(.fixed(100)),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        LazyVGrid(columns: three_columns) {
            Text("Income")
                .fontWeight(.bold)
                .foregroundColor(isExpense ? .gray : .black)
                //.font(isExpense ? .body : .title3)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Toggle(isOn: $isExpense) {

            }
            .toggleStyle(ColoredToggleStyle())
            .frame(maxWidth: .zero, alignment: .center)
            Text("Expense")
                .fontWeight(.bold)
                .foregroundColor(isExpense ? .black : .gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}




// MARK: - Amount
struct Amount: View {
    @Binding var amount: String
    
    var body: some View {
        HStack() {
            Text("Amount")
                //.bold()
                //.foregroundColor(.secondary)
            TextField(0.currencyFormat, text: $amount)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
                .font(Font.largeTitle.bold())
        }.frame(height: 50)
        //.padding()
    }
}

// MARK: - Selection
struct CategorySelection: View {
    @Binding var selectedCatergory: Category
    
    var body: some View {
        HStack {
            ForEach(Category.all, id:\.id) { category in
                Text(category.name)
            }
        }
        .padding()
    }
}




// MARK: preview
struct AddTransactionView_Previews: PreviewProvider {
    
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.items = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        Group {
            AddTransactionView(transactions: TransactionListViewModel(), selectedCategory: Category.autoAndTransport)
                .environmentObject(transactionListVM)
            AddTransactionView(transactions: TransactionListViewModel(), selectedCategory: Category.autoAndTransport)
                .preferredColorScheme(.dark)
                .environmentObject(transactionListVM)
        }
    }
        
}
