import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class OrderSummaryWidget extends StatefulWidget {
  final List<Map<String, dynamic>> orderItems;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;

  const OrderSummaryWidget({
    super.key,
    required this.orderItems,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
  });

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Summary',
                    style: AppTheme.lightTheme.textTheme.titleLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        '\$${widget.total.toStringAsFixed(2)}',
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          color: AppTheme.lightTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      CustomIconWidget(
                        iconName: _isExpanded
                            ? 'keyboard_arrow_up'
                            : 'keyboard_arrow_down',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            Divider(
              height: 1,
              color: AppTheme.lightTheme.dividerColor,
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                children: [
                  ...widget.orderItems.map((item) => _buildOrderItem(item)),
                  SizedBox(height: 2.h),
                  _buildPricingRow('Subtotal', widget.subtotal),
                  if (widget.deliveryFee > 0)
                    _buildPricingRow('Delivery Fee', widget.deliveryFee),
                  _buildPricingRow('Tax', widget.tax),
                  Divider(
                    color: AppTheme.lightTheme.dividerColor,
                    thickness: 1,
                  ),
                  _buildPricingRow('Total', widget.total, isTotal: true),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CustomImageWidget(
              imageUrl: item['image'] as String,
              width: 15.w,
              height: 15.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  '${item['quantity']}kg × \$${(item['price'] as double).toStringAsFixed(2)}/kg',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            '\$${((item['quantity'] as double) * (item['price'] as double)).toStringAsFixed(2)}',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  )
                : AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: isTotal
                ? AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.primaryColor,
                  )
                : AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
          ),
        ],
      ),
    );
  }
}
