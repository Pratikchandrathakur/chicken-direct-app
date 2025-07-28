import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/delivery_eligibility_widget.dart';
import './widgets/product_image_gallery_widget.dart';
import './widgets/product_info_card_widget.dart';
import './widgets/quantity_selector_widget.dart';
import './widgets/seller_communication_widget.dart';
import './widgets/sticky_bottom_section_widget.dart';
import './widgets/store_location_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isFavorite = false;
  double _selectedQuantity = 1.0;
  bool _isLoading = false;

  // Mock product data
  final Map<String, dynamic> _productData = {
    "id": 1,
    "name": "Premium Fresh Chicken Breast",
    "description":
        """High-quality, farm-fresh chicken breast sourced from local farms. Our chicken is antibiotic-free and raised in humane conditions. Perfect for grilling, baking, or pan-frying. Each piece is carefully selected for freshness and quality to ensure the best taste for your meals.""",
    "pricePerKg": 12.99,
    "rating": 4.8,
    "sellerName": "FreshMeat Co.",
    "sellerRating": 4.9,
    "images": [
      "https://images.pexels.com/photos/616354/pexels-photo-616354.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/2338407/pexels-photo-2338407.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "https://images.pexels.com/photos/1059943/pexels-photo-1059943.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    ],
    "inStock": true,
    "stockQuantity": 50.0,
  };

  final Map<String, dynamic> _sellerData = {
    "name": "FreshMeat Co.",
    "phone": "+1-555-0123",
    "rating": 4.9,
    "avatar":
        "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "responseTime": "Usually responds within 30 minutes",
  };

  final Map<String, dynamic> _storeData = {
    "name": "ChickenDirect Store - Downtown",
    "address": "123 Main Street, Downtown, NY 10001",
    "distance": "2.5",
    "closingTime": "9 PM",
    "latitude": 40.7128,
    "longitude": -74.0060,
  };

  final double _deliveryCharge = 5.99;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    Fluttertoast.showToast(
      msg: _isFavorite ? "Added to favorites" : "Removed from favorites",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _shareProduct() {
    Fluttertoast.showToast(
      msg: "Product shared successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _onQuantityChanged(double quantity) {
    setState(() {
      _selectedQuantity = quantity;
    });
  }

  void _addToCart() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Added ${_selectedQuantity.toStringAsFixed(1)}kg to cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pushNamed(context, '/shopping-cart-screen');
    });
  }

  void _buyNow() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamed(context, '/checkout-screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice =
        _selectedQuantity * (_productData["pricePerKg"] as double);

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 40.h,
                pinned: true,
                backgroundColor: AppTheme.lightTheme.colorScheme.surface,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: CustomIconWidget(
                      iconName: 'arrow_back',
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: _shareProduct,
                    icon: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: CustomIconWidget(
                        iconName: 'share',
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _toggleFavorite,
                    icon: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: CustomIconWidget(
                        iconName: _isFavorite ? 'favorite' : 'favorite_border',
                        color: _isFavorite ? Colors.red : Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: ProductImageGalleryWidget(
                    imageUrls: (_productData["images"] as List).cast<String>(),
                    heroTag: "product_${_productData["id"]}",
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    ProductInfoCardWidget(product: _productData),
                    QuantitySelectorWidget(
                      initialQuantity: _selectedQuantity,
                      pricePerKg: _productData["pricePerKg"] as double,
                      onQuantityChanged: _onQuantityChanged,
                    ),
                    DeliveryEligibilityWidget(
                      quantity: _selectedQuantity,
                      deliveryCharge: _deliveryCharge,
                    ),
                    SellerCommunicationWidget(seller: _sellerData),
                    StoreLocationWidget(store: _storeData),
                    SizedBox(height: 20.h), // Space for sticky bottom section
                  ],
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Processing...",
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: StickyBottomSectionWidget(
        quantity: _selectedQuantity,
        totalPrice: totalPrice,
        onAddToCart: _addToCart,
        onBuyNow: _buyNow,
      ),
    );
  }
}
