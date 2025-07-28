import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_chips.dart';
import './widgets/featured_products_carousel.dart';
import './widgets/product_grid.dart';
import './widgets/quick_order_card.dart';
import './widgets/search_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentTabIndex = 0;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;
  bool _isOffline = false;
  DateTime _lastUpdated = DateTime.now();

  final List<Map<String, dynamic>> _bottomNavItems = [
    {"icon": "home", "label": "Home", "route": "/home-screen"},
    {"icon": "receipt_long", "label": "Orders", "route": "/orders-screen"},
    {"icon": "chat", "label": "Chat", "route": "/chat-screen"},
    {"icon": "person", "label": "Profile", "route": "/profile-screen"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: _isOffline ? _buildOfflineState() : _buildMainContent(),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildMainContent() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _handleRefresh,
      color: AppTheme.lightTheme.primaryColor,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SearchHeader(),
                SizedBox(height: 2.h),
                const FeaturedProductsCarousel(),
                const QuickOrderCard(),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      Text(
                        'Categories',
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Navigate to all categories
                        },
                        child: Text('View All'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                const CategoryChips(),
                SizedBox(height: 3.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      Text(
                        'Fresh Products',
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppTheme.successLight.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: 'update',
                              color: AppTheme.successLight,
                              size: 12,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              'Updated ${_getTimeAgo(_lastUpdated)}',
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: AppTheme.successLight,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: _isLoading ? _buildLoadingState() : const ProductGrid(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10.h), // Bottom padding for FAB
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: _onBottomNavTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.lightTheme.colorScheme.surface,
        selectedItemColor: AppTheme.lightTheme.primaryColor,
        unselectedItemColor: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        elevation: 0,
        items: _bottomNavItems.map((item) {
          final index = _bottomNavItems.indexOf(item);
          return BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                color: _currentTabIndex == index
                    ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: item["icon"] as String,
                color: _currentTabIndex == index
                    ? AppTheme.lightTheme.primaryColor
                    : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
            label: item["label"] as String,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: _showBulkOrderCalculator,
      backgroundColor: AppTheme.lightTheme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
      icon: CustomIconWidget(
        iconName: 'calculate',
        color: Colors.white,
        size: 24,
      ),
      label: Text(
        'Bulk Order',
        style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          CircularProgressIndicator(
            color: AppTheme.lightTheme.primaryColor,
          ),
          SizedBox(height: 2.h),
          Text(
            'Loading fresh products...',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'wifi_off',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 64,
            ),
            SizedBox(height: 3.h),
            Text(
              'No Internet Connection',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Please check your connection and try again',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            ElevatedButton.icon(
              onPressed: _handleRefresh,
              icon: CustomIconWidget(
                iconName: 'refresh',
                color: Colors.white,
                size: 20,
              ),
              label: Text('Try Again'),
            ),
            SizedBox(height: 2.h),
            TextButton(
              onPressed: () {
                setState(() {
                  _isOffline = false;
                });
              },
              child: Text('Browse Cached Products'),
            ),
          ],
        ),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (index != _currentTabIndex) {
      setState(() {
        _currentTabIndex = index;
      });

      final route = _bottomNavItems[index]["route"] as String;
      if (route != "/home-screen") {
        Navigator.pushNamed(context, route);
      }
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isLoading = true;
      _isOffline = false;
    });

    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _lastUpdated = DateTime.now();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isOffline = true;
        _isLoading = false;
      });
    }
  }

  void _showBulkOrderCalculator() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.all(4.w),
              child: Column(
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
                      CustomIconWidget(
                        iconName: 'calculate',
                        color: AppTheme.lightTheme.primaryColor,
                        size: 28,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'Bulk Order Calculator',
                        style: AppTheme.lightTheme.textTheme.headlineSmall
                            ?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        _buildCalculatorCard(
                          'Minimum Order',
                          '20kg',
                          'Free delivery included',
                          'local_shipping',
                          AppTheme.successLight,
                        ),
                        _buildCalculatorCard(
                          'Bulk Discount',
                          'Up to 15%',
                          'Save more with larger orders',
                          'discount',
                          AppTheme.lightTheme.primaryColor,
                        ),
                        _buildCalculatorCard(
                          'Delivery Time',
                          '24-48 hours',
                          'Fresh delivery guaranteed',
                          'schedule',
                          AppTheme.warningLight,
                        ),
                        SizedBox(height: 3.h),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, '/product-detail-screen');
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                          ),
                          child: Text('Start Bulk Order'),
                        ),
                        SizedBox(height: 1.h),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Contact seller for custom orders
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                          ),
                          child: Text('Contact for Custom Order'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCalculatorCard(String title, String value, String description,
      String icon, Color iconColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: icon,
              color: iconColor,
              size: 24,
            ),
          ),
          SizedBox(width: 4.w),
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
                SizedBox(height: 0.5.h),
                Text(
                  value,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: iconColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 0.5.h),
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
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
