import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _buildCurrentStepContent(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAction(),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (currentStep) {
      case 0: return _buildAddressForm();
      case 1: return _buildPaymentForm();
      case 2: return _buildReviewForm();
      default: return const SizedBox.shrink();
    }
  }

  Widget _buildStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      color: AppColors.surface,
      child: Row(
        children: [
          _stepIcon(0, 'Delivery'),
          _stepLine(0),
          _stepIcon(1, 'Payment'),
          _stepLine(1),
          _stepIcon(2, 'Review'),
        ],
      ),
    );
  }

  Widget _stepIcon(int index, String label) {
    bool isActive = currentStep == index;
    bool isDone = currentStep > index;

    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isDone ? AppColors.green : (isActive ? AppColors.primary : AppColors.border1),
          child: isDone
              ? const Icon(Icons.check, size: 18, color: Colors.white)
              : Text('${index + 1}', style: TextStyle(color: isActive ? Colors.white : AppColors.text3, fontSize: 13, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: isActive ? FontWeight.bold : FontWeight.w600, color: isActive ? AppColors.primary : AppColors.text3)),
      ],
    );
  }

  Widget _stepLine(int index) {
    bool isDone = currentStep > index;
    return Expanded(
        child: Container(
            height: 2,
            color: isDone ? AppColors.primary : AppColors.border1,
            margin: const EdgeInsets.only(bottom: 20, left: 8, right: 8)
        )
    );
  }

  Widget _buildAddressForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('📍 Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const TextField(decoration: InputDecoration(hintText: 'Full Name')),
        const SizedBox(height: 16),
        const TextField(decoration: InputDecoration(hintText: 'Address Line 1')),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(child: TextField(decoration: InputDecoration(hintText: 'City'))),
            SizedBox(width: 16),
            Expanded(child: TextField(decoration: InputDecoration(hintText: 'PIN Code'))),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('💳 Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ListTile(
          tileColor: AppColors.primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.primary), // Fix applied here
          ),
          leading: const Icon(Icons.credit_card, color: AppColors.primary),
          title: const Text('Credit / Debit Card', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.radio_button_checked, color: AppColors.primary),
        ),
        const SizedBox(height: 12),
        const TextField(decoration: InputDecoration(hintText: 'Card Number')),
      ],
    );
  }

  Widget _buildReviewForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('📋 Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border1),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Subtotal', style: TextStyle(color: AppColors.text2)),
                  Text('₹1,19,999', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('₹1,19,999', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border1))
      ),
      child: SafeArea(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: currentStep == 2 ? AppColors.gold : AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
          ),
          onPressed: () {
            if (currentStep < 2) {
              setState(() => currentStep++);
            } else {
              // Finish Order and pop back to home
              Navigator.popUntil(context, ModalRoute.withName('/'));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order Placed Successfully! 🎉'), backgroundColor: AppColors.green),
              );
            }
          },
          child: Text(
            currentStep == 2 ? 'Place Order' : 'Continue to ${currentStep == 0 ? 'Payment' : 'Review'} →',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}