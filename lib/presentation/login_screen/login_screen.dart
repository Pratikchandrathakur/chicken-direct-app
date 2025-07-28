import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/app_logo_widget.dart';
import './widgets/login_form_widget.dart';
import './widgets/signup_prompt_widget.dart';
import './widgets/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String? _errorMessage;

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'customer@chickendirect.com': 'customer123',
    'seller@chickendirect.com': 'seller123',
    'admin@chickendirect.com': 'admin123',
  };

  Future<void> _handleLogin(String email, String password) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Check mock credentials
    if (_mockCredentials.containsKey(email) &&
        _mockCredentials[email] == password) {
      // Success - trigger haptic feedback
      HapticFeedback.lightImpact();

      // Navigate to home screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home-screen');
      }
    } else {
      // Error handling
      setState(() {
        _errorMessage = 'Invalid email or password. Please try again.';
      });

      // Error haptic feedback
      HapticFeedback.heavyImpact();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _handleSocialLogin(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider login functionality coming soon'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _handleSignupTap() {
    Navigator.pushNamed(context, '/registration-screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 8.h),

                    // App Logo Section
                    const AppLogoWidget(),
                    SizedBox(height: 6.h),

                    // Error Message
                    if (_errorMessage != null) ...[
                      Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.error
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: AppTheme.lightTheme.colorScheme.error
                                .withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'error_outline',
                              color: AppTheme.lightTheme.colorScheme.error,
                              size: 5.w,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.lightTheme.colorScheme.error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),
                    ],

                    // Login Form
                    LoginFormWidget(
                      onLogin: _handleLogin,
                      isLoading: _isLoading,
                    ),
                    SizedBox(height: 4.h),

                    // Social Login Options
                    SocialLoginWidget(
                      onGoogleLogin: () => _handleSocialLogin('Google'),
                      onAppleLogin: () => _handleSocialLogin('Apple'),
                      isLoading: _isLoading,
                    ),

                    // Spacer to push signup prompt to bottom
                    const Spacer(),

                    // Sign Up Prompt
                    SignupPromptWidget(
                      onSignupTap: _handleSignupTap,
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
