import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/registration_form_widget.dart';
import './widgets/welcome_animation_widget.dart';
import 'widgets/registration_form_widget.dart';
import 'widgets/welcome_animation_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isLoading = false;
  bool _showWelcomeAnimation = false;
  String? _errorMessage;

  // Mock existing users for validation
  final List<Map<String, dynamic>> _existingUsers = [
    {
      "email": "john.doe@example.com",
      "phone": "+1234567890",
    },
    {
      "email": "jane.smith@example.com",
      "phone": "+1987654321",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: _showWelcomeAnimation
          ? WelcomeAnimationWidget(
              onAnimationComplete: _navigateToHome,
            )
          : SafeArea(
              child: Column(
                children: [
                  // App Bar with Back Button
                  _buildAppBar(),

                  // Scrollable Form Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.h),

                          // Header Section
                          _buildHeader(),

                          SizedBox(height: 6.h),

                          // Error Message
                          if (_errorMessage != null) _buildErrorMessage(),

                          // Registration Form
                          RegistrationFormWidget(
                            onFormSubmit: _handleRegistration,
                            isLoading: _isLoading,
                          ),

                          SizedBox(height: 6.h),

                          // Login Link
                          _buildLoginLink(),

                          SizedBox(height: 4.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.lightTheme.colorScheme.surface,
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 5.w,
                ),
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                'Create Account',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(width: 10.w), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo/Brand Section
        Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'restaurant',
                  color: Colors.white,
                  size: 6.w,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              'ChickenDirect',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        SizedBox(height: 4.h),

        // Welcome Text
        Text(
          'Join ChickenDirect',
          style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 1.h),

        Text(
          'Create your account to start ordering fresh chicken with bulk discounts and direct seller communication.',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 4.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'error',
            color: AppTheme.lightTheme.colorScheme.error,
            size: 5.w,
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(
              _errorMessage!,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, '/login-screen'),
        child: RichText(
          text: TextSpan(
            style: AppTheme.lightTheme.textTheme.bodyMedium,
            children: [
              TextSpan(text: 'Already have an account? '),
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRegistration(Map<String, String> formData) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Add haptic feedback
    HapticFeedback.lightImpact();

    try {
      // Simulate network delay
      await Future.delayed(Duration(milliseconds: 1500));

      // Check for duplicate email
      final existingUser = _existingUsers.any(
        (user) =>
            (user["email"] as String).toLowerCase() ==
            formData['email']!.toLowerCase(),
      );

      if (existingUser) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'An account with this email already exists. Please use a different email or sign in to your existing account.';
        });
        return;
      }

      // Check for duplicate phone
      final existingPhone = _existingUsers.any(
        (user) => user["phone"] == formData['phone'],
      );

      if (existingPhone) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'An account with this phone number already exists. Please use a different phone number.';
        });
        return;
      }

      // Validate password strength (additional server-side check)
      if (formData['password']!.length < 8) {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'Password must be at least 8 characters long with a mix of letters, numbers, and special characters.';
        });
        return;
      }

      // Simulate successful registration
      setState(() {
        _isLoading = false;
        _showWelcomeAnimation = true;
      });

      // Add success haptic feedback
      HapticFeedback.mediumImpact();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Registration failed due to network connectivity issues. Please check your internet connection and try again.';
      });

      // Add error haptic feedback
      HapticFeedback.heavyImpact();
    }
  }

  void _navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home-screen',
      (route) => false,
    );
  }
}