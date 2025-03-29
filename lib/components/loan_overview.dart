import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanOverview extends StatelessWidget {
  final Map<String, dynamic> loanData;
  final currencyFormat = NumberFormat.currency(symbol: '\$');

  LoanOverview({
    super.key,
    required this.loanData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Loan Overview",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            _buildInfoRow("Loan Amount", currencyFormat.format(loanData['loan_amount'])),
            _buildInfoRow("Remaining Balance", currencyFormat.format(loanData['remaining_balance'])),
            _buildInfoRow("Status", loanData['repayment_status']),
            _buildInfoRow(
              "Next Payment Due",
              DateFormat('MMM dd, yyyy').format(loanData['next_due_date'].toDate()),
            ),
            _buildInfoRow(
              "Total Paid",
              currencyFormat.format(loanData['total_paid']),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}