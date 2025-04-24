import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:explorer_web/services/user_service.dart';
import 'package:explorer_web/services/loan_service.dart';
import 'package:intl/intl.dart';
import 'package:explorer_web/components/loan_overview.dart';
import 'package:explorer_web/components/payment_history.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final LoanService _loanService = LoanService();
  final UserService _userService = UserService();
  final currencyFormat = NumberFormat.currency(symbol: '\$');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fetch and display the user's name
            FutureBuilder<Map<String, dynamic>?>(
  future: _userService.getUserDetails(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text("Error fetching user data: ${snapshot.error}"));
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text("User not found"));
    }

    final userData = snapshot.data!;
    final firstName = userData['f_name'] ?? 'User';

    return Text(
      "Hey, $firstName!",
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  },
),
            const SizedBox(height: 24),
      StreamBuilder<QuerySnapshot>(
        stream: _loanService.getCurrentUserLoan(),
        builder: (context, loanSnapshot) {
          if (loanSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!loanSnapshot.hasData || loanSnapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No active loans found",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _loanService.seedInitialData(),
                    child: const Text("Create Sample Loan Data"),
                  ),
                ],
              ),
            );
          }

          final loanData = loanSnapshot.data!.docs.first.data() as Map<String, dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoanOverview(loanData: loanData),
              const SizedBox(height: 24),
              Expanded(
                child: PaymentHistory(
                  loanId: loanData['loan_id'],
                  loanService: _loanService,
                ),
              ),
            ],
          );
        },
      ),
    ])));
  }
}