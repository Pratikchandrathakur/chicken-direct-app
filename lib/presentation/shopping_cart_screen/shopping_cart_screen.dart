import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/cart_item_card.dart';
import './widgets/delivery_address_section.dart';
import './widgets/delivery_eligibility_banner.dart';
import './widgets/empty_cart_widget.dart';
import './widgets/order_summary_card.dart';
import './widgets/seller_contact_section.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      'id': 1,
      'name': 'Premium Chicken Breast',
      'seller': 'Fresh Farms Co.',
      'image':
          'https://images.pexels.com/photos/616401/pexels-photo-616401.jpeg',
      'quantity': 5,
      'pricePerKg': 12.99,
    },
    {
      'id': 2,
      'name': 'Organic Chicken Thighs',
      'seller': 'Green Valley Meats',
      'image':
          'https://images.pexels.com/photos/1059943/pexels-photo-1059943.jpeg',
      'quantity': 8,
      'pricePerKg': 9.99,
    },
    {
      'id': 3,
      'name': 'Free-Range Whole Chicken',
      'seller': 'Farm Fresh Direct',
      'image':
          'https://images.pexels.com/photos/1059905/pexels-photo-1059905.jpeg',
      'quantity': 3,
      'pricePerKg': 15.99,
    },
  ];

  Map<String, dynamic>? selectedAddress = {
    'id': 1,
    'type': 'Home',
    'name': 'John Smith',
    'address': '123 Oak Street, Downtown District, Springfield, IL 62701',
    'phone': '+1 (555) 123-4567',
    'isDefault': true,
  };

  final List<Map<String, dynamic>> addresses = [
    {
      'id': 1,
      'type': 'Home',
      'name': 'John Smith',
      'address': '123 Oak Street, Downtown District, Springfield, IL 62701',
      'phone': '+1 (555) 123-4567',
      'isDefault': true,
    },
    {
      'id': 2,
      'type': 'Work',
      'name': 'John Smith',
      'address': '456 Business Ave, Corporate Center, Springfield, IL 62702',
      'phone': '+1 (555) 123-4567',
      'isDefault': false,
    },
    {
      'id': 3,
      'type': 'Other',
      'name': 'Sarah Johnson',
      'address': '789 Maple Drive, Residential Area, Springfield, IL 62703',
      'phone': '+1 (555) 987-6543',
      'isDefault': false,
    },
  ];

  double get totalWeight {
    return cartItems.fold(
        0.0, (sum, item) => sum + (item['quantity'] as int).toDouble());
  }

  double get subtotal {
    return cartItems.fold(0.0, (sum, item) {
      final quantity = item['quantity'] as int;
      final price = item['pricePerKg'] as double;
      return sum + (quantity * price);
    });
  }

  double get deliveryCharges {
    if (totalWeight >= 20) return 0.0; // Free delivery
    if (totalWeight < 5) return 0.0; // Pickup required
    return 8.99; // Standard delivery charge
  }

  double get taxes {
    return subtotal * 0.08; // 8% tax
  }

  double get total {
    return subtotal + deliveryCharges + taxes;
  }

  List<Map<String, dynamic>> get sellers {
    final Map<String, Map<String, dynamic>> sellerMap = {};

    for (final item in cartItems) {
      final sellerName = item['seller'] as String;
      if (!sellerMap.containsKey(sellerName)) {
        sellerMap[sellerName] = {
          'name': sellerName,
          'rating': 4.5 + (sellerName.hashCode % 10) / 20, // Mock rating
          'reviews': 150 + (sellerName.hashCode % 500),
          'isVerified': sellerName.hashCode % 2 == 0,
          'phone':
              '+1 (555) ${100 + (sellerName.hashCode % 900)}-${1000 + (sellerName.hashCode % 9000)}',
          'businessHours': '8:00 AM - 6:00 PM',
          'isOpen': DateTime.now().hour >= 8 && DateTime.now().hour < 18,
          'items': <Map<String, dynamic>>[],
        };
      }

      (sellerMap[sellerName]!['items'] as List).add({
        'name': item['name'],
        'quantity': item['quantity'],
        'subtotal': (item['quantity'] as int) * (item['pricePerKg'] as double),
      });
    }

    return sellerMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            TextButton(
              onPressed: _showClearCartDialog,
              child: Text(
                'Clear All',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.error,
                ),
              ),
            ),
        ],
      ),
      body: cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      bottomNavigationBar:
          cartItems.isNotEmpty ? _buildBottomCheckoutBar() : null,
    );
  }

  Widget _buildEmptyCart() {
    return EmptyCartWidget(
      onStartShopping: () {
        Navigator.pushNamed(context, '/home-screen');
      },
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Delivery Eligibility Banner
                DeliveryEligibilityBanner(
                  totalWeight: totalWeight,
                ),

                // Cart Items List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return CartItemCard(
                      item: item,
                      onDelete: () => _removeItem(index),
                      onQuantityChanged: (newQuantity) =>
                          _updateQuantity(index, newQuantity),
                      onMoveToFavorites: () => _moveToFavorites(index),
                    );
                  },
                ),

                SizedBox(height: 2.h),

                // Order Summary
                OrderSummaryCard(
                  subtotal: subtotal,
                  deliveryCharges: deliveryCharges,
                  taxes: taxes,
                  total: total,
                  totalWeight: totalWeight,
                ),

                // Delivery Address Section
                if (totalWeight >= 5)
                  DeliveryAddressSection(
                    selectedAddress: selectedAddress,
                    onAddressSelect: _showAddressSelection,
                    onAddressEdit: _editAddress,
                  ),

                // Seller Contact Section
                SellerContactSection(
                  sellers: sellers,
                ),

                SizedBox(height: 10.h), // Space for bottom bar
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomCheckoutBar() {
    final canProceed = totalWeight >= 5 ? selectedAddress != null : true;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total (${totalWeight.toStringAsFixed(1)}kg)',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryLight,
                      ),
                    ),
                  ],
                ),
                if (deliveryCharges == 0 && totalWeight >= 20)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: AppTheme.successLight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.successLight.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'local_shipping',
                          color: AppTheme.successLight,
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'Free Delivery',
                          style: AppTheme.lightTheme.textTheme.labelSmall
                              ?.copyWith(
                            color: AppTheme.successLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: canProceed ? _proceedToCheckout : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.5.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: canProceed ? 4 : 0,
                  backgroundColor: canProceed
                      ? AppTheme.primaryLight
                      : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName:
                          totalWeight < 5 ? 'store' : 'shopping_cart_checkout',
                      size: 6.w,
                      color: Colors.white,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      totalWeight < 5
                          ? 'Find Store for Pickup'
                          : 'Proceed to Checkout',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!canProceed && totalWeight >= 5) ...[
              SizedBox(height: 1.h),
              Text(
                'Please select a delivery address to continue',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _removeItem(int index) {
    HapticFeedback.mediumImpact();
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      cartItems[index]['quantity'] = newQuantity;
    });
  }

  void _moveToFavorites(int index) {
    HapticFeedback.lightImpact();
    // Implement move to favorites functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${cartItems[index]['name']} moved to favorites'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Implement undo functionality
          },
        ),
      ),
    );
  }

  void _showClearCartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear Cart',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        content: Text(
          'Are you sure you want to remove all items from your cart?',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                cartItems.clear();
              });
              Navigator.of(context).pop();
            },
            child: Text(
              'Clear All',
              style: TextStyle(color: AppTheme.lightTheme.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressSelection() {
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
              'Select Delivery Address',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            ...addresses.map((address) => ListTile(
                  leading: CustomIconWidget(
                    iconName: address['type'] == 'Home'
                        ? 'home'
                        : address['type'] == 'Work'
                            ? 'work'
                            : 'location_on',
                    color: AppTheme.primaryLight,
                    size: 6.w,
                  ),
                  title: Text('${address['type']} - ${address['name']}'),
                  subtitle: Text(address['address']),
                  trailing: selectedAddress?['id'] == address['id']
                      ? CustomIconWidget(
                          iconName: 'check_circle',
                          color: AppTheme.successLight,
                          size: 6.w,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      selectedAddress = address;
                    });
                    Navigator.pop(context);
                  },
                )),
            SizedBox(height: 2.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate to add address screen
                },
                icon: CustomIconWidget(
                  iconName: 'add',
                  size: 5.w,
                  color: Colors.white,
                ),
                label: const Text('Add New Address'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }

  void _editAddress() {
    // Navigate to edit address screen
  }

  void _proceedToCheckout() {
    if (totalWeight < 5) {
      // Show store locator or pickup options
      return;
    }

    HapticFeedback.mediumImpact();
    Navigator.pushNamed(context, '/checkout-screen');
  }
}
