import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StickyBottomSectionWidget extends StatelessWidget {
  final double quantity;
  final double totalPrice;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  const StickyBottomSectionWidget({
    Key? key,
    required this.quantity,
    required this.totalPrice,
    required this.onAddToCart,
    required this.onBuyNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quantity: ${quantity.toStringAsFixed(1)} kg",
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Total: \$${totalPrice.toStringAsFixed(2)}",
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: quantity >= 20.0
                            ? AppTheme.lightTheme.colorScheme.tertiary
                            : quantity >= 5.0
                                ? Colors.orange
                                : Colors.red,
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Text(
                        quantity >= 20.0
                            ? "FREE DELIVERY"
                            : quantity >= 5.0
                                ? "STANDARD DELIVERY"
                                : "PICKUP ONLY",
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: OutlinedButton.icon(
                      onPressed: onAddToCart,
                      icon: CustomIconWidget(
                        iconName: 'shopping_cart',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 20,
                      ),
                      label: Text("Add to Cart"),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    flex: 3,
                    child: ElevatedButton.icon(
                      onPressed: onBuyNow,
                      icon: CustomIconWidget(
                        iconName: 'flash_on',
                        color: Colors.white,
                        size: 20,
                      ),
                      label: Text("Buy Now"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                      ),
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
}
