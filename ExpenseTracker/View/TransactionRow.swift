import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction: Transaction

    var body: some View {
        HStack(spacing: 20) {
            // MARK: Transaction category Icon
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.icon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                // MARK: Transaction Category
                Text(transaction.categoryName)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                // MARK: Transaction Date
                Text(transaction.date) //.dateParsed, format: .dateTime.year().month().day()
                    .font(.footnote)
                    .foregroundColor(.secondary)
                /// test row to visualize dateparsed
                //Text(transaction.dateParsed.formatted(.dateTime.year().month(.wide)))
            }
            Spacer()
            // MARK: Transaction Amount
            Text(transaction.signedAmount, format:  .currency(code: "USD"))
                .bold()
                .foregroundColor(transaction.isExpense == false ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
    }
    
//    func color(for amount: Double) -> Color {
//        amount > 0 ? .green : .primary
//    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: transactionPreviewData)
        TransactionRow(transaction: transactionPreviewData)
            .preferredColorScheme(.dark)
    }
}
