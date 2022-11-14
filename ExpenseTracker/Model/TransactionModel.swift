//
//  TransactionModel.swift
//  ExpenseTracker
//
//  Created by HWorld on 10/15/22.
//

import Foundation
import SwiftUIFontIcon

// MARK: each entry has to be unique, therefore we make this struct conformable to Identifiable protocol
struct Transaction : Identifiable, Codable, Hashable {
    // the properties declared as 'let' are readonly, the others are editable
    // making the id a 'var' will allow it to be decoded, but it will also allow callers to modify it.
    // By making it as provate(set) var instead, we can disallow that
    private(set) var id = UUID()
    let date: String
    let amount : Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var categoryName: String
    var note: String
    var isExpense : Bool
    var isEdited: Bool
    
    // MARK: computed properties
    // MARK: the reason behind adding all the computed properties directly in the data model, is due to the fact that we were not planning to create a view model for an independent transaction, such as "TransactionViewModel". The view model wasn't necessary as there's nothing to fetch and no functions to involve
    var dateParsed : Date {
        date.dateParsed()
    }
    var signedAmount: Double {
        //return type == TransactionType.credit.rawValue ? amount : -amount
        return isExpense == false ? amount : -amount
    }
    var icon: FontAwesomeCode {
        if let category = Category.all.first(where: { $0.id == categoryId }) {
            return category.icon
        }
        return .question
    }
    
    var month: String {
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
    
}

enum TransactionType: String {
    case debit = "debit"
    case credit = "credit"
}


struct Category: Hashable {
    var id: Int
    let name: String
    let icon: FontAwesomeCode
    let isExpense: Bool
    var mainCategoryId: Int?
}

extension Category {
    static let autoAndTransport = Category(id: 1, name: "Transports", icon: .car_alt, isExpense: true)
    static let billsAndUtilities = Category(id: 2, name: "Bills", icon: .file_invoice_dollar, isExpense: true)
    static let entertainment = Category(id: 3, name: "Entertainment", icon: .film, isExpense: true)
    
    static let salary = Category(id: 9, name: "Salary", icon: .cash_register, isExpense: false)
    static let rental = Category(id: 9, name: "Rental", icon: .money_bill, isExpense: false)
    static let selling = Category(id: 9, name: "Selling", icon: .receipt, isExpense: false)
    
    
//    static let publicTransport = Category(id: 101, name: "Public Transports", icon: .bus, isExpense: true, mainCategoryId: 1)
//    static let taxi = Category(id: 102, name: "Taxi", icon: .taxi, isExpense: true, mainCategoryId: 1)
//    static let mobilePhone = Category(id: 201, name: "Mobile Phone", icon: .mobile_alt, isExpense: true, mainCategoryId: 2)
//    static let moviesAndDVDs = Category(id: 301, name: "Movies & DVDs", icon: .film, isExpense: true, mainCategoryId: 3)
}
extension Category {
    static let expenseCategories: [Category] = [
        .autoAndTransport,
        .billsAndUtilities,
        .entertainment,
    ]
    static let incomeCategories: [Category] = [
        .salary,
        .rental,
        .selling
    ]
    
//    static let subCategories: [Category] = [
//        .publicTransport,
//        .taxi,
//        .mobilePhone,
//        .moviesAndDVDs
//    ]

    static let all: [Category] = expenseCategories + incomeCategories
}
