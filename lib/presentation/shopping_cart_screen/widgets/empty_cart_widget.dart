import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyCartWidget extends StatelessWidget {
  final VoidCallback onStartShopping;

  const EmptyCartWidget({
    Key? key,
    required this.onStartShopping,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Appetizing chicken imagery
            Container(
              width: 60.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowLight,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CustomImageWidget(
                  imageUrl:
                      'https://images.pexels.com/photos/616401/pexels-photo-616401.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  width: 60.w,
                  height: 40.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 4.h),

            // Empty cart icon
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'shopping_cart',
                size: 12.w,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 3.h),

            // Main message
            Text(
              'Your Cart is Empty',
              style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),

            // Descriptive text
            Text(
              'Looks like you haven\'t added any delicious chicken products to your cart yet. Start exploring our fresh selection!',
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),

            // Benefits section
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Why Choose ChickenDirect?',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryLight,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  _buildBenefitItem(
                    'local_shipping',
                    'Free Delivery',
                    'On orders 20kg and above',
                  ),
                  SizedBox(height: 1.5.h),
                  _buildBenefitItem(
                    'verified',
                    'Fresh Quality',
                    'Premium chicken from trusted sellers',
                  ),
                  SizedBox(height: 1.5.h),
                  _buildBenefitItem(
                    'chat',
                    'Direct Communication',
                    'Chat or call sellers directly',
                  ),
                  SizedBox(height: 1.5.h),
                  _buildBenefitItem(
                    'store',
                    'Flexible Pickup',
                    'Convenient store locations',
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),

            // CTA Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStartShopping,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.5.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'shopping_bag',
                      size: 6.w,
                      color: Colors.white,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'Start Shopping',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),

            // Secondary action
            TextButton.icon(
              onPressed: () {
                // Navigate to categories or featured products
              },
              icon: CustomIconWidget(
                iconName: 'category',
                size: 5.w,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
              label: Text(
                'Browse Categories',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String iconName, String title, String description) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryLight.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomIconWidget(
            iconName: iconName,
            size: 5.w,
            color: AppTheme.primaryLight,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
