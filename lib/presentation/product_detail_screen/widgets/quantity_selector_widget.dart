import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuantitySelectorWidget extends StatefulWidget {
  final double initialQuantity;
  final double pricePerKg;
  final Function(double) onQuantityChanged;

  const QuantitySelectorWidget({
    Key? key,
    required this.initialQuantity,
    required this.pricePerKg,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  State<QuantitySelectorWidget> createState() => _QuantitySelectorWidgetState();
}

class _QuantitySelectorWidgetState extends State<QuantitySelectorWidget> {
  late TextEditingController _quantityController;
  late double _currentQuantity;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.initialQuantity;
    _quantityController =
        TextEditingController(text: _currentQuantity.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _updateQuantity(double newQuantity) {
    if (newQuantity >= 0.5) {
      setState(() {
        _currentQuantity = newQuantity;
        _quantityController.text = newQuantity.toStringAsFixed(1);
      });
      widget.onQuantityChanged(newQuantity);
    }
  }

  void _incrementQuantity() {
    _updateQuantity(_currentQuantity + 0.5);
  }

  void _decrementQuantity() {
    if (_currentQuantity > 0.5) {
      _updateQuantity(_currentQuantity - 0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = _currentQuantity * widget.pricePerKg;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quantity Selection",
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Text(
                  "Quantity (kg):",
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: _decrementQuantity,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          child: CustomIconWidget(
                            iconName: 'remove',
                            color: AppTheme.lightTheme.colorScheme.primary,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        width: 20.w,
                        child: TextFormField(
                          controller: _quantityController,
                          textAlign: TextAlign.center,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*')),
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                          ),
                          onChanged: (value) {
                            double? newQuantity = double.tryParse(value);
                            if (newQuantity != null && newQuantity >= 0.5) {
                              _updateQuantity(newQuantity);
                            }
                          },
                        ),
                      ),
                      InkWell(
                        onTap: _incrementQuantity,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          child: CustomIconWidget(
                            iconName: 'add',
                            color: AppTheme.lightTheme.colorScheme.primary,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(2.w),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price:",
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                  Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
