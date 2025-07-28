import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PaymentMethodWidget extends StatefulWidget {
  final List<Map<String, dynamic>> paymentMethods;
  final String? selectedPaymentId;
  final Function(String) onPaymentMethodSelected;

  const PaymentMethodWidget({
    super.key,
    required this.paymentMethods,
    this.selectedPaymentId,
    required this.onPaymentMethodSelected,
  });

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'payment',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 24,
                ),
                SizedBox(width: 3.w),
                Text(
                  'Payment Method',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: 2.h),
            ...widget.paymentMethods
                .map((method) => _buildPaymentMethodCard(method)),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodCard(Map<String, dynamic> method) {
    final bool isSelected = widget.selectedPaymentId == method['id'];
    final String type = method['type'] as String;

    return GestureDetector(
      onTap: () => widget.onPaymentMethodSelected(method['id'] as String),
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.05)
              : AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.lightTheme.primaryColor
                : AppTheme.lightTheme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: _getPaymentMethodColor(type).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: _getPaymentMethodIcon(type),
                  color: _getPaymentMethodColor(type),
                  size: 24,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method['name'] as String,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (method['details'] != null) ...[
                    SizedBox(height: 0.5.h),
                    Text(
                      method['details'] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ],
                  if (method['processingFee'] != null &&
                      (method['processingFee'] as double) > 0) ...[
                    SizedBox(height: 0.5.h),
                    Text(
                      'Processing fee: \$${(method['processingFee'] as double).toStringAsFixed(2)}',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.warningLight,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (method['isSecure'] == true) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.successLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'security',
                      color: AppTheme.successLight,
                      size: 12,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Secure',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.successLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.w),
            ],
            Radio<String>(
              value: method['id'] as String,
              groupValue: widget.selectedPaymentId,
              onChanged: (value) {
                if (value != null) {
                  widget.onPaymentMethodSelected(value);
                }
              },
              activeColor: AppTheme.lightTheme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  String _getPaymentMethodIcon(String type) {
    switch (type.toLowerCase()) {
      case 'credit_card':
      case 'debit_card':
        return 'credit_card';
      case 'apple_pay':
        return 'apple';
      case 'google_pay':
        return 'google';
      case 'paypal':
        return 'account_balance_wallet';
      case 'cash':
        return 'money';
      default:
        return 'payment';
    }
  }

  Color _getPaymentMethodColor(String type) {
    switch (type.toLowerCase()) {
      case 'credit_card':
      case 'debit_card':
        return AppTheme.lightTheme.primaryColor;
      case 'apple_pay':
        return Colors.black;
      case 'google_pay':
        return Colors.blue;
      case 'paypal':
        return Colors.indigo;
      case 'cash':
        return AppTheme.successLight;
      default:
        return AppTheme.lightTheme.colorScheme.onSurface;
    }
  }
}
