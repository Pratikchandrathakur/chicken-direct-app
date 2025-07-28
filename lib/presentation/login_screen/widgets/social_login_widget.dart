import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SocialLoginWidget extends StatelessWidget {
  final VoidCallback? onGoogleLogin;
  final VoidCallback? onAppleLogin;
  final bool isLoading;

  const SocialLoginWidget({
    Key? key,
    this.onGoogleLogin,
    this.onAppleLogin,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with "OR" text
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppTheme.lightTheme.dividerColor,
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'OR',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: AppTheme.lightTheme.dividerColor,
                thickness: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),

        // Social Login Buttons
        Row(
          children: [
            // Google Login Button
            Expanded(
              child: SizedBox(
                height: 6.h,
                child: OutlinedButton(
                  onPressed: isLoading ? null : onGoogleLogin,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppTheme.lightTheme.dividerColor,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageWidget(
                        imageUrl:
                            'https://developers.google.com/identity/images/g-logo.png',
                        width: 5.w,
                        height: 5.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Google',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 3.w),

            // Apple Login Button
            Expanded(
              child: SizedBox(
                height: 6.h,
                child: OutlinedButton(
                  onPressed: isLoading ? null : onAppleLogin,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppTheme.lightTheme.dividerColor,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'apple',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Apple',
                        style:
                            AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
