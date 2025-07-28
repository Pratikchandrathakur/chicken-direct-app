import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class FeaturedProductsCarousel extends StatefulWidget {
  const FeaturedProductsCarousel({super.key});

  @override
  State<FeaturedProductsCarousel> createState() =>
      _FeaturedProductsCarouselState();
}

class _FeaturedProductsCarouselState extends State<FeaturedProductsCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> featuredProducts = [
    {
      "id": 1,
      "name": "Premium Whole Chicken",
      "image":
          "https://images.pexels.com/photos/616354/pexels-photo-616354.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "price": "\$8.99",
      "originalPrice": "\$12.99",
      "discount": "30% OFF",
      "description": "Fresh, organic whole chicken perfect for family meals",
      "rating": 4.8,
      "seller": "FreshMeat Co."
    },
    {
      "id": 2,
      "name": "Chicken Breast Fillets",
      "image":
          "https://images.pexels.com/photos/2338407/pexels-photo-2338407.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "price": "\$12.49",
      "originalPrice": "\$15.99",
      "discount": "22% OFF",
      "description": "Boneless, skinless chicken breast - high protein",
      "rating": 4.9,
      "seller": "Quality Poultry"
    },
    {
      "id": 3,
      "name": "Organic Free-Range Chicken",
      "image":
          "https://images.pexels.com/photos/1059943/pexels-photo-1059943.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "price": "\$15.99",
      "originalPrice": "\$19.99",
      "discount": "20% OFF",
      "description": "Ethically raised, free-range organic chicken",
      "rating": 4.7,
      "seller": "Green Farm"
    }
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.h,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: featuredProducts.length,
              itemBuilder: (context, index) {
                final product = featuredProducts[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.lightTheme.colorScheme.shadow
                            .withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        CustomImageWidget(
                          imageUrl: product["image"] as String,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 3.h,
                          right: 4.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: AppTheme.errorLight,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product["discount"] as String,
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 3.h,
                          left: 4.w,
                          right: 4.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product["name"] as String,
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                product["description"] as String,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 1.h),
                              Row(
                                children: [
                                  Text(
                                    product["price"] as String,
                                    style: AppTheme
                                        .lightTheme.textTheme.titleMedium
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    product["originalPrice"] as String,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall
                                        ?.copyWith(
                                      color:
                                          Colors.white.withValues(alpha: 0.7),
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      CustomIconWidget(
                                        iconName: 'star',
                                        color: AppTheme.warningLight,
                                        size: 16,
                                      ),
                                      SizedBox(width: 1.w),
                                      Text(
                                        product["rating"].toString(),
                                        style: AppTheme
                                            .lightTheme.textTheme.bodySmall
                                            ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              featuredProducts.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                width: _currentPage == index ? 8.w : 2.w,
                height: 1.h,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppTheme.lightTheme.primaryColor
                      : AppTheme.lightTheme.primaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
