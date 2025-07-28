import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProductInfoCardWidget extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductInfoCardWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product["name"] ?? "Product Name",
              style: AppTheme.lightTheme.textTheme.headlineMedium,
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Text(
                  "\$${(product["pricePerKg"] as double).toStringAsFixed(2)}/kg",
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                CustomIconWidget(
                  iconName: 'star',
                  color: Colors.amber,
                  size: 20,
                ),
                SizedBox(width: 1.w),
                Text(
                  "${product["rating"]}",
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'store',
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product["sellerName"] ?? "Seller Name",
                        style: AppTheme.lightTheme.textTheme.titleMedium,
                      ),
                      Text(
                        "Verified Seller",
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.tertiary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'star',
                        color: AppTheme.lightTheme.colorScheme.tertiary,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        "${product["sellerRating"]}",
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.tertiary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              "Description",
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 1.h),
            Text(
              product["description"] ?? "Product description not available.",
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
