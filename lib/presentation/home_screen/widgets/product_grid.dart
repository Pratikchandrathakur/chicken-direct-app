import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final Set<int> favoriteProducts = {};

  final List<Map<String, dynamic>> products = [
    {
      "id": 1,
      "name": "Fresh Whole Chicken",
      "image":
          "https://images.pexels.com/photos/616354/pexels-photo-616354.jpeg?auto=compress&cs=tinysrgb&w=800",
      "price": "\$8.99",
      "pricePerKg": "\$8.99/kg",
      "seller": "FreshMeat Co.",
      "rating": 4.8,
      "reviews": 124,
      "inStock": true,
      "weight": "1.2-1.5kg",
      "description": "Farm-fresh whole chicken, perfect for roasting"
    },
    {
      "id": 2,
      "name": "Chicken Breast Fillets",
      "image":
          "https://images.pexels.com/photos/2338407/pexels-photo-2338407.jpeg?auto=compress&cs=tinysrgb&w=800",
      "price": "\$12.49",
      "pricePerKg": "\$12.49/kg",
      "seller": "Quality Poultry",
      "rating": 4.9,
      "reviews": 89,
      "inStock": true,
      "weight": "500g pack",
      "description": "Boneless, skinless chicken breast fillets"
    },
    {
      "id": 3,
      "name": "Chicken Thighs",
      "image":
          "https://images.pexels.com/photos/1059943/pexels-photo-1059943.jpeg?auto=compress&cs=tinysrgb&w=800",
      "price": "\$7.99",
      "pricePerKg": "\$7.99/kg",
      "seller": "Local Farm",
      "rating": 4.7,
      "reviews": 156,
      "inStock": true,
      "weight": "800g pack",
      "description": "Juicy chicken thighs with bone and skin"
    },
    {
      "id": 4,
      "name": "Ground Chicken",
      "image":
          "https://images.pexels.com/photos/1435735/pexels-photo-1435735.jpeg?auto=compress&cs=tinysrgb&w=800",
      "price": "\$9.99",
      "pricePerKg": "\$9.99/kg",
      "seller": "Premium Meats",
      "rating": 4.6,
      "reviews": 78,
      "inStock": true,
      "weight": "500g pack",
      "description": "Freshly ground chicken, lean and versatile"
    },
    {
      "id": 5,
      "name": "Organic Free-Range",
      "image":
          "https://images.pexels.com/photos/1059943/pexels-photo-1059943.jpeg?auto=compress&cs=tinysrgb&w=800",
      "price": "\$15.99",
      "pricePerKg": "\$15.99/kg",
      "seller": "Green Farm",
      "rating": 4.9,
      "reviews": 203,
      "inStock": false,
      "weight": "1.5-2kg",
      "description": "Certified organic, free-range whole chicken"
    },
    {
      "id": 6,
      "name": "Chicken Wings",
      "image":
          "https://images.pexels.com/photos/60616/fried-chicken-chicken-fried-crunchy-60616.jpeg?auto=compress&cs=tinysrgb&w=800",
      "price": "\$6.99",
      "pricePerKg": "\$6.99/kg",
      "seller": "Wing Master",
      "rating": 4.5,
      "reviews": 92,
      "inStock": true,
      "weight": "1kg pack",
      "description": "Fresh chicken wings, perfect for grilling"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.w,
          mainAxisSpacing: 4.w,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final isFavorite = favoriteProducts.contains(product["id"]);
          final isInStock = product["inStock"] as bool;

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/product-detail-screen');
            },
            onLongPress: () {
              _showQuickActions(context, product);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.lightTheme.colorScheme.shadow
                        .withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: CustomImageWidget(
                            imageUrl: product["image"] as String,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (!isInStock)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.6),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  color: AppTheme.errorLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Out of Stock',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 2.w,
                          right: 2.w,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isFavorite) {
                                  favoriteProducts.remove(product["id"]);
                                } else {
                                  favoriteProducts.add(product["id"] as int);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                              ),
                              child: CustomIconWidget(
                                iconName:
                                    isFavorite ? 'favorite' : 'favorite_border',
                                color: isFavorite
                                    ? AppTheme.errorLight
                                    : AppTheme.lightTheme.colorScheme.onSurface,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 2.w,
                          left: 2.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            decoration: BoxDecoration(
                              color: AppTheme.lightTheme.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomIconWidget(
                                  iconName: 'star',
                                  color: Colors.white,
                                  size: 12,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  product["rating"].toString(),
                                  style: AppTheme
                                      .lightTheme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["name"] as String,
                            style: AppTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            product["weight"] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product["price"] as String,
                                      style: AppTheme
                                          .lightTheme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: AppTheme.lightTheme.primaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      product["seller"] as String,
                                      style: AppTheme
                                          .lightTheme.textTheme.bodySmall
                                          ?.copyWith(
                                        color: AppTheme.lightTheme.colorScheme
                                            .onSurfaceVariant,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: isInStock
                                    ? () {
                                        _addToCart(product);
                                      }
                                    : null,
                                child: Container(
                                  padding: EdgeInsets.all(2.w),
                                  decoration: BoxDecoration(
                                    color: isInStock
                                        ? AppTheme.lightTheme.primaryColor
                                        : AppTheme.lightTheme.colorScheme
                                            .onSurfaceVariant
                                            .withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: CustomIconWidget(
                                    iconName: 'add_shopping_cart',
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showQuickActions(BuildContext context, Map<String, dynamic> product) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CustomImageWidget(
                      imageUrl: product["image"] as String,
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
                          product["name"] as String,
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          product["seller"] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Column(
                children: [
                  _buildQuickActionTile(
                    context,
                    'View Details',
                    'visibility',
                    () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/product-detail-screen');
                    },
                  ),
                  _buildQuickActionTile(
                    context,
                    'Contact Seller',
                    'phone',
                    () {
                      Navigator.pop(context);
                      _contactSeller(product);
                    },
                  ),
                  _buildQuickActionTile(
                    context,
                    'Add to Favorites',
                    'favorite_border',
                    () {
                      Navigator.pop(context);
                      setState(() {
                        favoriteProducts.add(product["id"] as int);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickActionTile(
      BuildContext context, String title, String icon, VoidCallback onTap) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: AppTheme.lightTheme.primaryColor,
        size: 24,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyLarge,
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void _addToCart(Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product["name"]} added to cart'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            Navigator.pushNamed(context, '/shopping-cart-screen');
          },
        ),
      ),
    );
  }

  void _contactSeller(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Contact ${product["seller"]}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'phone',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 24,
                ),
                title: Text('Call Seller'),
                subtitle: Text('+1 (555) 123-4567'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement phone call functionality
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'chat',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 24,
                ),
                title: Text('Live Chat'),
                subtitle: Text('Start a conversation'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to chat screen
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
