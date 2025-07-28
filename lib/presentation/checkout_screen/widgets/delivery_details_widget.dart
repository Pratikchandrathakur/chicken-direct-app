import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DeliveryDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> deliveryInfo;
  final VoidCallback onChangeAddress;
  final VoidCallback? onViewDirections;

  const DeliveryDetailsWidget({
    super.key,
    required this.deliveryInfo,
    required this.onChangeAddress,
    this.onViewDirections,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDelivery = deliveryInfo['type'] == 'delivery';
    final bool isFreeDelivery = deliveryInfo['isFree'] == true;
    final double totalWeight = deliveryInfo['totalWeight'] ?? 0.0;

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
                  iconName: isDelivery ? 'local_shipping' : 'store',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 24,
                ),
                SizedBox(width: 3.w),
                Text(
                  isDelivery ? 'Delivery Details' : 'Pickup Details',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: 2.h),
            _buildDeliveryStatus(totalWeight, isFreeDelivery, isDelivery),
            SizedBox(height: 2.h),
            _buildAddressCard(isDelivery),
            if (isDelivery) ...[
              SizedBox(height: 2.h),
              _buildDeliveryTime(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryStatus(
      double totalWeight, bool isFreeDelivery, bool isDelivery) {
    Color statusColor;
    String statusText;
    String iconName;

    if (!isDelivery) {
      statusColor = AppTheme.lightTheme.colorScheme.tertiary;
      statusText = 'Store Pickup Available';
      iconName = 'check_circle';
    } else if (isFreeDelivery) {
      statusColor = AppTheme.successLight;
      statusText = 'Free Delivery (${totalWeight.toStringAsFixed(1)}kg)';
      iconName = 'check_circle';
    } else if (totalWeight < 5.0) {
      statusColor = AppTheme.warningLight;
      statusText =
          'Paid Delivery (\$${deliveryInfo['deliveryFee']?.toStringAsFixed(2) ?? '0.00'})';
      iconName = 'info';
    } else {
      statusColor = AppTheme.warningLight;
      statusText = 'Delivery Available';
      iconName = 'local_shipping';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: statusColor,
            size: 20,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              statusText,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(bool isDelivery) {
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
          Row(
            children: [
              CustomIconWidget(
                iconName: isDelivery ? 'location_on' : 'store',
                color: AppTheme.lightTheme.primaryColor,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  isDelivery ? 'Delivery Address' : 'Pickup Location',
                  style: AppTheme.lightTheme.textTheme.titleSmall,
                ),
              ),
              TextButton(
                onPressed: isDelivery ? onChangeAddress : onViewDirections,
                child: Text(
                  isDelivery ? 'Change' : 'Directions',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.lightTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            deliveryInfo['address'] as String? ?? 'No address selected',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (!isDelivery && deliveryInfo['storeHours'] != null) ...[
            SizedBox(height: 1.h),
            Text(
              'Store Hours: ${deliveryInfo['storeHours']}',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDeliveryTime() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.tertiaryContainer
            .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'schedule',
            color: AppTheme.lightTheme.colorScheme.tertiary,
            size: 20,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Estimated Delivery',
                  style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.tertiary,
                  ),
                ),
                Text(
                  deliveryInfo['estimatedTime'] as String? ?? '45-60 minutes',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
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
}
