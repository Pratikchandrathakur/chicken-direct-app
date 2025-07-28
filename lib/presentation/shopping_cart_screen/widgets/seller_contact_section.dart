import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_export.dart';

class SellerContactSection extends StatelessWidget {
  final List<Map<String, dynamic>> sellers;

  const SellerContactSection({
    Key? key,
    required this.sellers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sellers.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'store',
                  color: AppTheme.primaryLight,
                  size: 6.w,
                ),
                SizedBox(width: 3.w),
                Text(
                  'Seller Information',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryLight,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            ...sellers.map((seller) => _buildSellerCard(context, seller)),
          ],
        ),
      ),
    );
  }

  Widget _buildSellerCard(BuildContext context, Map<String, dynamic> seller) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 6.w,
                backgroundColor: AppTheme.primaryLight.withValues(alpha: 0.1),
                child: CustomIconWidget(
                  iconName: 'store',
                  color: AppTheme.primaryLight,
                  size: 6.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      seller['name'] as String,
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'star',
                          color: Colors.amber,
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '${seller['rating']} (${seller['reviews']} reviews)',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: seller['isVerified'] == true
                      ? AppTheme.successLight.withValues(alpha: 0.1)
                      : AppTheme.warningLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName:
                          seller['isVerified'] == true ? 'verified' : 'info',
                      color: seller['isVerified'] == true
                          ? AppTheme.successLight
                          : AppTheme.warningLight,
                      size: 3.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      seller['isVerified'] == true ? 'Verified' : 'Pending',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: seller['isVerified'] == true
                            ? AppTheme.successLight
                            : AppTheme.warningLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Items from this seller
          Text(
            'Items from this seller:',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.h),

          ...(seller['items'] as List).map((item) => Padding(
                padding: EdgeInsets.only(bottom: 0.5.h),
                child: Row(
                  children: [
                    Text(
                      '• ${item['name']} (${item['quantity']}kg)',
                      style: AppTheme.lightTheme.textTheme.bodySmall,
                    ),
                    const Spacer(),
                    Text(
                      '\$${item['subtotal'].toStringAsFixed(2)}',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )),

          SizedBox(height: 2.h),

          // Communication buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _makePhoneCall(seller['phone'] as String),
                  icon: CustomIconWidget(
                    iconName: 'phone',
                    size: 4.w,
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  ),
                ),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _startChat(context, seller),
                  icon: CustomIconWidget(
                    iconName: 'chat',
                    size: 4.w,
                    color: Colors.white,
                  ),
                  label: const Text('Chat'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  ),
                ),
              ),
            ],
          ),

          // Business hours
          if (seller['businessHours'] != null) ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'schedule',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 4.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Hours: ${seller['businessHours']}',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: seller['isOpen'] == true
                          ? AppTheme.successLight.withValues(alpha: 0.2)
                          : AppTheme.errorLight.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      seller['isOpen'] == true ? 'Open' : 'Closed',
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: seller['isOpen'] == true
                            ? AppTheme.successLight
                            : AppTheme.errorLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (e) {
      // Handle error silently or show user-friendly message
    }
  }

  void _startChat(BuildContext context, Map<String, dynamic> seller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: 70.h,
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.3),
                  ),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 5.w,
                    backgroundColor:
                        AppTheme.primaryLight.withValues(alpha: 0.1),
                    child: CustomIconWidget(
                      iconName: 'store',
                      color: AppTheme.primaryLight,
                      size: 5.w,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          seller['name'] as String,
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          seller['isOpen'] == true ? 'Online' : 'Offline',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: seller['isOpen'] == true
                                ? AppTheme.successLight
                                : AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      size: 6.w,
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                children: [
                  _buildChatMessage(
                    'Hello! I have a question about my order.',
                    true,
                    DateTime.now().subtract(const Duration(minutes: 5)),
                  ),
                  _buildChatMessage(
                    'Hi! I\'d be happy to help. What would you like to know?',
                    false,
                    DateTime.now().subtract(const Duration(minutes: 3)),
                  ),
                  _buildChatMessage(
                    'When will my order be ready for pickup?',
                    true,
                    DateTime.now().subtract(const Duration(minutes: 2)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppTheme.lightTheme.colorScheme.outline
                        .withValues(alpha: 0.3),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  ElevatedButton(
                    onPressed: () {
                      // Send message functionality
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(3.w),
                    ),
                    child: CustomIconWidget(
                      iconName: 'send',
                      size: 5.w,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMessage(String message, bool isUser, DateTime timestamp) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 4.w,
              backgroundColor: AppTheme.primaryLight.withValues(alpha: 0.1),
              child: CustomIconWidget(
                iconName: 'store',
                color: AppTheme.primaryLight,
                size: 4.w,
              ),
            ),
            SizedBox(width: 2.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: isUser
                    ? AppTheme.primaryLight
                    : AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: isUser
                    ? null
                    : Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
                      ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: isUser ? Colors.white : null,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: isUser
                          ? Colors.white.withValues(alpha: 0.7)
                          : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 2.w),
            CircleAvatar(
              radius: 4.w,
              backgroundColor: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.1),
              child: CustomIconWidget(
                iconName: 'person',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 4.w,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
