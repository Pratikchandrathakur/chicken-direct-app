import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/delivery_details_widget.dart';
import './widgets/order_summary_widget.dart';
import './widgets/order_timeline_widget.dart';
import './widgets/payment_method_widget.dart';
import './widgets/special_instructions_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isLoading = false;
  String? _selectedPaymentId;
  String _specialInstructions = '';

  // Mock data for checkout
  final List<Map<String, dynamic>> _orderItems = [
    {
      "id": 1,
      "name": "Fresh Whole Chicken",
      "image":
          "https://images.pexels.com/photos/616354/pexels-photo-616354.jpeg",
      "quantity": 15.0,
      "price": 8.50,
    },
    {
      "id": 2,
      "name": "Chicken Breast (Boneless)",
      "image":
          "https://images.pexels.com/photos/2338407/pexels-photo-2338407.jpeg",
      "quantity": 8.0,
      "price": 12.99,
    },
  ];

  final Map<String, dynamic> _deliveryInfo = {
    "type": "delivery",
    "isFree": true,
    "totalWeight": 23.0,
    "deliveryFee": 0.0,
    "address": "123 Main Street, Apt 4B\nNew York, NY 10001\nUnited States",
    "estimatedTime": "45-60 minutes",
  };

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      "id": "card_1",
      "type": "credit_card",
      "name": "Visa ending in 4242",
      "details": "Expires 12/26",
      "isSecure": true,
      "processingFee": 0.0,
    },
    {
      "id": "apple_pay",
      "type": "apple_pay",
      "name": "Apple Pay",
      "details": "Touch ID or Face ID",
      "isSecure": true,
      "processingFee": 0.0,
    },
    {
      "id": "google_pay",
      "type": "google_pay",
      "name": "Google Pay",
      "details": "Biometric authentication",
      "isSecure": true,
      "processingFee": 0.0,
    },
    {
      "id": "cash",
      "type": "cash",
      "name": "Cash on Delivery",
      "details": "Pay when you receive your order",
      "isSecure": false,
      "processingFee": 2.50,
    },
  ];

  final Map<String, dynamic> _timelineInfo = {
    "preparationTime": "15-20 minutes",
    "deliveryTime": "45-60 minutes",
    "isDelivery": true,
    "sellerName": "ChickenDirect Premium Store",
    "sellerPhone": "+1 (555) 123-4567",
  };

  double get _subtotal {
    return _orderItems.fold(
        0.0,
        (sum, item) =>
            sum + ((item['quantity'] as double) * (item['price'] as double)));
  }

  double get _deliveryFee {
    return _deliveryInfo['deliveryFee'] as double? ?? 0.0;
  }

  double get _processingFee {
    if (_selectedPaymentId == null) return 0.0;
    final selectedMethod = _paymentMethods.firstWhere(
      (method) => method['id'] == _selectedPaymentId,
      orElse: () => {'processingFee': 0.0},
    );
    return selectedMethod['processingFee'] as double? ?? 0.0;
  }

  double get _tax {
    return (_subtotal + _deliveryFee + _processingFee) * 0.08; // 8% tax
  }

  double get _total {
    return _subtotal + _deliveryFee + _processingFee + _tax;
  }

  @override
  void initState() {
    super.initState();
    _selectedPaymentId = _paymentMethods.first['id'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: AppTheme.lightTheme.appBarTheme.elevation,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              children: [
                SizedBox(height: 1.h),
                OrderSummaryWidget(
                  orderItems: _orderItems,
                  subtotal: _subtotal,
                  deliveryFee: _deliveryFee + _processingFee,
                  tax: _tax,
                  total: _total,
                ),
                DeliveryDetailsWidget(
                  deliveryInfo: _deliveryInfo,
                  onChangeAddress: _handleChangeAddress,
                  onViewDirections: _handleViewDirections,
                ),
                PaymentMethodWidget(
                  paymentMethods: _paymentMethods,
                  selectedPaymentId: _selectedPaymentId,
                  onPaymentMethodSelected: _handlePaymentMethodSelected,
                ),
                SpecialInstructionsWidget(
                  initialInstructions: _specialInstructions,
                  onInstructionsChanged: _handleInstructionsChanged,
                ),
                OrderTimelineWidget(
                  timelineInfo: _timelineInfo,
                  onContactSeller: _handleContactSeller,
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
          _buildBottomSection(),
          if (_isLoading) _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                  Text(
                    '\$${_total.toStringAsFixed(2)}',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.lightTheme.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton(
                  onPressed:
                      _selectedPaymentId != null ? _handlePlaceOrder : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightTheme.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'shopping_cart_checkout',
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Place Order',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppTheme.lightTheme.primaryColor,
              ),
              SizedBox(height: 2.h),
              Text(
                'Processing Payment...',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'security',
                    color: AppTheme.successLight,
                    size: 16,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Secure Transaction',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.successLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleChangeAddress() {
    // Navigate to address selection screen
    Fluttertoast.showToast(
      msg: "Address change functionality",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleViewDirections() {
    // Open maps with store location
    Fluttertoast.showToast(
      msg: "Opening directions to store",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handlePaymentMethodSelected(String paymentId) {
    setState(() {
      _selectedPaymentId = paymentId;
    });
  }

  void _handleInstructionsChanged(String instructions) {
    _specialInstructions = instructions;
  }

  void _handleContactSeller() {
    // Implement phone calling functionality
    Fluttertoast.showToast(
      msg: "Calling seller: ${_timelineInfo['sellerPhone']}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  Future<void> _handlePlaceOrder() async {
    if (_selectedPaymentId == null) {
      Fluttertoast.showToast(
        msg: "Please select a payment method",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 3));

      // Simulate payment success
      final bool paymentSuccess =
          true; // In real app, this would be from payment gateway

      if (paymentSuccess) {
        _showOrderConfirmation();
      } else {
        _showPaymentError();
      }
    } catch (e) {
      _showPaymentError();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showOrderConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: AppTheme.successLight.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'check_circle',
                  color: AppTheme.successLight,
                  size: 40,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Order Placed Successfully!',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              'Order #CD${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Your order has been confirmed and is being prepared. You will receive updates via notifications.',
              style: AppTheme.lightTheme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/home-screen');
                },
                child: Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'error',
              color: AppTheme.errorLight,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text(
              'Payment Failed',
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
          ],
        ),
        content: Text(
          'There was an issue processing your payment. Please check your payment method and try again.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Try Again',
              style: TextStyle(color: AppTheme.lightTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
