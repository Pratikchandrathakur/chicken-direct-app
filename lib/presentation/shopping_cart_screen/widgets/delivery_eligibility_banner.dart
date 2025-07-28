import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DeliveryEligibilityBanner extends StatelessWidget {
  final double totalWeight;
  final double deliveryThreshold;
  final double freeDeliveryThreshold;

  const DeliveryEligibilityBanner({
    Key? key,
    required this.totalWeight,
    this.deliveryThreshold = 5.0,
    this.freeDeliveryThreshold = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bannerData = _getBannerData();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: bannerData['backgroundColor'],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: bannerData['borderColor'],
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: bannerData['icon'],
                color: bannerData['iconColor'],
                size: 6.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  bannerData['title'],
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: bannerData['textColor'],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            bannerData['message'],
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: bannerData['textColor'],
            ),
          ),
          if (totalWeight < freeDeliveryThreshold) ...[
            SizedBox(height: 2.h),
            _buildProgressBar(),
            SizedBox(height: 1.h),
            Text(
              'Add ${(freeDeliveryThreshold - totalWeight).toStringAsFixed(1)}kg more for free delivery!',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: bannerData['textColor'],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          if (bannerData['actionText'] != null) ...[
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (totalWeight < deliveryThreshold) {
                    // Navigate to store locator or show pickup options
                    _showPickupOptions(context);
                  } else {
                    // Show upgrade suggestions
                    _showUpgradeSuggestions(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: bannerData['buttonColor'],
                  foregroundColor: bannerData['buttonTextColor'],
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
                child: Text(bannerData['actionText']),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Map<String, dynamic> _getBannerData() {
    if (totalWeight >= freeDeliveryThreshold) {
      // Green banner - Free delivery eligible
      return {
        'backgroundColor': AppTheme.successLight.withValues(alpha: 0.1),
        'borderColor': AppTheme.successLight,
        'icon': 'local_shipping',
        'iconColor': AppTheme.successLight,
        'textColor': AppTheme.successLight,
        'title': 'Free Delivery Eligible!',
        'message':
            'Your order qualifies for free delivery. We\'ll deliver to your doorstep at no extra cost.',
        'actionText': null,
        'buttonColor': null,
        'buttonTextColor': null,
      };
    } else if (totalWeight >= deliveryThreshold) {
      // Amber banner - Mixed eligibility
      return {
        'backgroundColor': AppTheme.warningLight.withValues(alpha: 0.1),
        'borderColor': AppTheme.warningLight,
        'icon': 'info',
        'iconColor': AppTheme.warningLight,
        'textColor': AppTheme.warningLight,
        'title': 'Delivery Available',
        'message':
            'Delivery charges apply for orders under ${freeDeliveryThreshold.toInt()}kg. Consider adding more items for free delivery.',
        'actionText': 'View Suggestions',
        'buttonColor': AppTheme.warningLight,
        'buttonTextColor': Colors.white,
      };
    } else {
      // Red banner - Under threshold
      return {
        'backgroundColor': AppTheme.errorLight.withValues(alpha: 0.1),
        'borderColor': AppTheme.errorLight,
        'icon': 'store',
        'iconColor': AppTheme.errorLight,
        'textColor': AppTheme.errorLight,
        'title': 'Pickup Recommended',
        'message':
            'Orders under ${deliveryThreshold.toInt()}kg require pickup from store. Find the nearest store location.',
        'actionText': 'Find Store',
        'buttonColor': AppTheme.errorLight,
        'buttonTextColor': Colors.white,
      };
    }
  }

  Widget _buildProgressBar() {
    final progress = (totalWeight / freeDeliveryThreshold).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${totalWeight.toStringAsFixed(1)}kg',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${freeDeliveryThreshold.toInt()}kg',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Container(
          height: 1.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(0.5.h),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.successLight,
                borderRadius: BorderRadius.circular(0.5.h),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showPickupOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Store Pickup Options',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.primaryLight,
                size: 6.w,
              ),
              title: const Text('Downtown Store'),
              subtitle: const Text('123 Main St - 0.5 miles away'),
              trailing: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate to store details or map
                },
                child: const Text('Directions'),
              ),
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.primaryLight,
                size: 6.w,
              ),
              title: const Text('Westside Market'),
              subtitle: const Text('456 Oak Ave - 1.2 miles away'),
              trailing: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate to store details or map
                },
                child: const Text('Directions'),
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  void _showUpgradeSuggestions(BuildContext context) {
    final List<Map<String, dynamic>> suggestions = [
      {
        'name': 'Premium Chicken Breast',
        'image':
            'https://images.pexels.com/photos/616401/pexels-photo-616401.jpeg',
        'weight': 2.5,
        'price': 15.99,
      },
      {
        'name': 'Organic Chicken Thighs',
        'image':
            'https://images.pexels.com/photos/1059943/pexels-photo-1059943.jpeg',
        'weight': 3.0,
        'price': 12.99,
      },
      {
        'name': 'Free-Range Whole Chicken',
        'image':
            'https://images.pexels.com/photos/1059905/pexels-photo-1059905.jpeg',
        'weight': 4.0,
        'price': 18.99,
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add More for Free Delivery',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Add any of these items to qualify for free delivery:',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            SizedBox(height: 2.h),
            ...suggestions.map((item) => ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CustomImageWidget(
                      imageUrl: item['image'],
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(item['name']),
                  subtitle: Text('${item['weight']}kg - \$${item['price']}'),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Add item to cart or navigate to product
                    },
                    child: const Text('Add'),
                  ),
                )),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
