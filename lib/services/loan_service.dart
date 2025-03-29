import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoanService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user's loan
  Stream<QuerySnapshot> getCurrentUserLoan() {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore
          .collection('loans')
          .where('user_id', isEqualTo: user.uid)
          .snapshots();
    }
    throw Exception('No user logged in');
  }

  // Get payment history for a loan
  Stream<QuerySnapshot> getLoanPayments(String loanId) {
    return _firestore
        .collection('payments')
        .where('loan_id', isEqualTo: loanId)
        .orderBy('payment_date', descending: true)
        .snapshots();
  }

  // Helper method to seed initial data (only for development)
  Future<void> seedInitialData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    // Create a loan document
    final loanRef = _firestore.collection('loans').doc();
    final now = DateTime.now();
    
    await loanRef.set({
      'loan_id': loanRef.id,
      'user_id': user.uid,
      'loan_amount': 10000.0,
      'remaining_balance': 8500.0,
      'start_date': now,
      'repayment_schedule': [
        {
          'date': now.add(const Duration(days: 30)),
          'amount': 500.0,
        },
        {
          'date': now.add(const Duration(days: 60)),
          'amount': 500.0,
        },
      ],
      'repayment_status': 'active',
      'next_due_date': now.add(const Duration(days: 30)),
      'interest_rate': 0.05,
      'total_paid': 1500.0,
      'last_payment_date': now.subtract(const Duration(days: 15)),
      'created_at': now,
      'updated_at': now,
    });

    // Create some sample payments
    final payments = [
      {
        'payment_id': DateTime.now().millisecondsSinceEpoch.toString(),
        'loan_id': loanRef.id,
        'payment_amount': 750.0,
        'payment_date': now.subtract(const Duration(days: 15)),
        'payment_method': 'Bank Transfer',
        'payment_status': 'success',
        'created_at': now.subtract(const Duration(days: 15)),
      },
      {
        'payment_id': (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        'loan_id': loanRef.id,
        'payment_amount': 750.0,
        'payment_date': now.subtract(const Duration(days: 45)),
        'payment_method': 'Bank Transfer',
        'payment_status': 'success',
        'created_at': now.subtract(const Duration(days: 45)),
      },
    ];

    for (var payment in payments) {
      await _firestore.collection('payments').add(payment);
    }
  }
}