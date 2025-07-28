import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OrderTimelineWidget extends StatelessWidget {
  final Map<String, dynamic> timelineInfo;
  final VoidCallback onContactSeller;

  const OrderTimelineWidget({
    super.key,
    required this.timelineInfo,
    required this.onContactSeller,
  });

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
                  iconName: 'schedule',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 24,
                ),
                SizedBox(width: 3.w),
                Text(
                  'Order Timeline',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: 2.h),
            _buildTimelineStep(
              'Order Confirmation',
              'Immediate',
              'check_circle',
              AppTheme.successLight,
              isCompleted: true,
            ),
            _buildTimelineStep(
              'Preparation',
              timelineInfo['preparationTime'] as String? ?? '15-20 minutes',
              'restaurant',
              AppTheme.warningLight,
            ),
            _buildTimelineStep(
              timelineInfo['isDelivery'] == true
                  ? 'Delivery'
                  : 'Ready for Pickup',
              timelineInfo['deliveryTime'] as String? ?? '30-45 minutes',
              timelineInfo['isDelivery'] == true ? 'local_shipping' : 'store',
              AppTheme.lightTheme.primaryColor,
            ),
            SizedBox(height: 2.h),
            _buildSellerContact(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(
    String title,
    String time,
    String iconName,
    Color color, {
    bool isCompleted = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: isCompleted ? color : color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: color,
                width: isCompleted ? 0 : 2,
              ),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: iconName,
                color: isCompleted ? Colors.white : color,
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isCompleted
                        ? AppTheme.lightTheme.colorScheme.onSurface
                        : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  time,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerContact() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.lightTheme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Seller Contact',
            style: AppTheme.lightTheme.textTheme.titleSmall,
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              CircleAvatar(
                radius: 6.w,
                backgroundColor:
                    AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                child: CustomIconWidget(
                  iconName: 'store',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timelineInfo['sellerName'] as String? ??
                          'ChickenDirect Store',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      timelineInfo['sellerPhone'] as String? ??
                          '+1 (555) 123-4567',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed: onContactSeller,
                icon: CustomIconWidget(
                  iconName: 'phone',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 16,
                ),
                label: Text(
                  'Call',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.lightTheme.primaryColor,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  minimumSize: Size(0, 0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
