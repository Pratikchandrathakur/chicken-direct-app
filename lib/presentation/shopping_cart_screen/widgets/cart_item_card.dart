import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CartItemCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onDelete;
  final Function(int) onQuantityChanged;
  final VoidCallback? onMoveToFavorites;

  const CartItemCard({
    Key? key,
    required this.item,
    required this.onDelete,
    required this.onQuantityChanged,
    this.onMoveToFavorites,
  }) : super(key: key);

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  bool _showContextMenu = false;

  void _handleLongPress() {
    HapticFeedback.mediumImpact();
    setState(() {
      _showContextMenu = !_showContextMenu;
    });
  }

  void _incrementQuantity() {
    HapticFeedback.lightImpact();
    final currentQuantity = widget.item['quantity'] as int;
    widget.onQuantityChanged(currentQuantity + 1);
  }

  void _decrementQuantity() {
    HapticFeedback.lightImpact();
    final currentQuantity = widget.item['quantity'] as int;
    if (currentQuantity > 1) {
      widget.onQuantityChanged(currentQuantity - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final quantity = item['quantity'] as int;
    final pricePerKg = item['pricePerKg'] as double;
    final subtotal = quantity * pricePerKg;

    return Dismissible(
      key: Key(item['id'].toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        HapticFeedback.heavyImpact();
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Remove Item',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            content: Text(
              'Are you sure you want to remove ${item['name']} from your cart?',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Remove'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) => widget.onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomIconWidget(
          iconName: 'delete',
          color: Colors.white,
          size: 6.w,
        ),
      ),
      child: GestureDetector(
        onLongPress: _handleLongPress,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(3.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CustomImageWidget(
                        imageUrl: item['image'] as String,
                        width: 20.w,
                        height: 20.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 3.w),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] as String,
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.5.h),

                          Text(
                            'Seller: ${item['seller']}',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: 1.h),

                          // Price per kg
                          Text(
                            '\$${pricePerKg.toStringAsFixed(2)}/kg',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.primaryLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 1.h),

                          // Quantity Controls
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        AppTheme.lightTheme.colorScheme.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: _decrementQuantity,
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        padding: EdgeInsets.all(2.w),
                                        child: CustomIconWidget(
                                          iconName: 'remove',
                                          size: 4.w,
                                          color: quantity > 1
                                              ? AppTheme.lightTheme.colorScheme
                                                  .onSurface
                                              : AppTheme.lightTheme.colorScheme
                                                  .onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 3.w),
                                      child: Text(
                                        '${quantity}kg',
                                        style: AppTheme
                                            .lightTheme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: _incrementQuantity,
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        padding: EdgeInsets.all(2.w),
                                        child: CustomIconWidget(
                                          iconName: 'add',
                                          size: 4.w,
                                          color: AppTheme
                                              .lightTheme.colorScheme.onSurface,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),

                              // Subtotal
                              Text(
                                '\$${subtotal.toStringAsFixed(2)}',
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                  color: AppTheme.primaryLight,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Context Menu
              if (_showContextMenu)
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface
                        .withValues(alpha: 0.8),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() => _showContextMenu = false);
                            widget.onMoveToFavorites?.call();
                          },
                          icon: CustomIconWidget(
                            iconName: 'favorite_border',
                            size: 4.w,
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                          label: Text(
                            'Move to Favorites',
                            style: AppTheme.lightTheme.textTheme.labelMedium,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() => _showContextMenu = false);
                            _showBulkQuantityDialog();
                          },
                          icon: CustomIconWidget(
                            iconName: 'edit',
                            size: 4.w,
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                          label: Text(
                            'Bulk Adjust',
                            style: AppTheme.lightTheme.textTheme.labelMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBulkQuantityDialog() {
    final TextEditingController controller = TextEditingController(
      text: widget.item['quantity'].toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Adjust Quantity',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter new quantity for ${widget.item['name']}',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity (kg)',
                suffixText: 'kg',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newQuantity = int.tryParse(controller.text) ?? 1;
              if (newQuantity > 0) {
                widget.onQuantityChanged(newQuantity);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
