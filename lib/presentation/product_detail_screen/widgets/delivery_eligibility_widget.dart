import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DeliveryEligibilityWidget extends StatelessWidget {
  final double quantity;
  final double deliveryCharge;

  const DeliveryEligibilityWidget({
    Key? key,
    required this.quantity,
    required this.deliveryCharge,
  }) : super(key: key);

  Map<String, dynamic> _getDeliveryInfo() {
    if (quantity >= 20.0) {
      return {
        'status': 'free',
        'title': 'Free Delivery',
        'subtitle': 'Eligible for free delivery (20kg+)',
        'color': AppTheme.lightTheme.colorScheme.tertiary,
        'icon': 'local_shipping',
        'charge': 0.0,
      };
    } else if (quantity >= 5.0) {
      return {
        'status': 'standard',
        'title': 'Standard Delivery',
        'subtitle': 'Delivery charge: \$${deliveryCharge.toStringAsFixed(2)}',
        'color': Colors.orange,
        'icon': 'local_shipping',
        'charge': deliveryCharge,
      };
    } else {
      return {
        'status': 'pickup',
        'title': 'Pickup Only',
        'subtitle': 'Order below 5kg - pickup required or pay delivery fee',
        'color': Colors.red,
        'icon': 'store',
        'charge': deliveryCharge * 1.5,
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final deliveryInfo = _getDeliveryInfo();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery Information",
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: (deliveryInfo['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.w),
                border: Border.all(
                  color: deliveryInfo['color'] as Color,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: deliveryInfo['color'] as Color,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: CustomIconWidget(
                      iconName: deliveryInfo['icon'] as String,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deliveryInfo['title'] as String,
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: deliveryInfo['color'] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          deliveryInfo['subtitle'] as String,
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (quantity < 5.0) ...[
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery Options:",
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'store',
                          color: AppTheme.lightTheme.colorScheme.secondary,
                          size: 16,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          "Store Pickup - Free",
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'local_shipping',
                          color: AppTheme.lightTheme.colorScheme.secondary,
                          size: 16,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          "Home Delivery - \$${(deliveryCharge * 1.5).toStringAsFixed(2)}",
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
