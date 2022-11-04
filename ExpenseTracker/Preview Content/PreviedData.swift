//
//  PreviedData.swift
//  ExpenseTracker
//
//  Created by HWorld on 10/15/22.
//

import Foundation


var transactionPreviewData = Transaction(date: "19/10/2022", amount: 11, type: "debit", categoryId: 801, categoryName: "Software", note: "licenza software", isExpense: true, isEdited: false)


var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
