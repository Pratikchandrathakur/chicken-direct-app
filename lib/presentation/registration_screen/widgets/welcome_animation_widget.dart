import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WelcomeAnimationWidget extends StatefulWidget {
  final VoidCallback onAnimationComplete;

  const WelcomeAnimationWidget({
    Key? key,
    required this.onAnimationComplete,
  }) : super(key: key);

  @override
  State<WelcomeAnimationWidget> createState() => _WelcomeAnimationWidgetState();
}

class _WelcomeAnimationWidgetState extends State<WelcomeAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _slideController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    // Start scale animation
    _scaleController.forward();

    // Start fade animation after a short delay
    await Future.delayed(Duration(milliseconds: 200));
    _fadeController.forward();

    // Start slide animation
    await Future.delayed(Duration(milliseconds: 100));
    _slideController.forward();

    // Complete animation after total duration
    await Future.delayed(Duration(milliseconds: 2500));
    widget.onAnimationComplete();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
            AppTheme.lightTheme.scaffoldBackgroundColor,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Success Icon with Scale Animation
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 25.w,
              height: 25.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.successLight,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.successLight.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'check',
                  color: Colors.white,
                  size: 12.w,
                ),
              ),
            ),
          ),

          SizedBox(height: 6.h),

          // Welcome Text with Fade Animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  Text(
                    'Welcome to ChickenDirect!',
                    style:
                        AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      'Your account has been created successfully. Get ready to explore fresh chicken products with bulk ordering benefits and direct seller communication.',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Feature Highlights with Fade Animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  children: [
                    _buildFeatureHighlight(
                      icon: 'local_shipping',
                      title: 'Free Delivery on 20kg+ Orders',
                      description: 'Enjoy free delivery for bulk orders',
                    ),
                    SizedBox(height: 3.h),
                    _buildFeatureHighlight(
                      icon: 'chat',
                      title: 'Direct Seller Communication',
                      description: 'Chat and call sellers directly',
                    ),
                    SizedBox(height: 3.h),
                    _buildFeatureHighlight(
                      icon: 'store',
                      title: 'Flexible Pickup Options',
                      description: 'Choose delivery or store pickup',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureHighlight({
    required String icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: icon,
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 6.w,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
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
    );
  }
}
