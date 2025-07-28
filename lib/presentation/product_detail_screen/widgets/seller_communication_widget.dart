import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_export.dart';

class SellerCommunicationWidget extends StatelessWidget {
  final Map<String, dynamic> seller;

  const SellerCommunicationWidget({
    Key? key,
    required this.seller,
  }) : super(key: key);

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch phone dialer';
      }
    } catch (e) {
      print('Error making phone call: $e');
    }
  }

  void _openChat(BuildContext context) {
    // Navigate to chat screen or show chat bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(5.w)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(5.w)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 3.w,
                    backgroundImage: NetworkImage(seller["avatar"] ?? ""),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          seller["name"] ?? "Seller",
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Online now",
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          _buildChatMessage(
                            "Hello! I'm interested in your chicken products. Are they fresh?",
                            true,
                            DateTime.now().subtract(Duration(minutes: 5)),
                          ),
                          _buildChatMessage(
                            "Yes, all our chicken is fresh and delivered daily. What quantity are you looking for?",
                            false,
                            DateTime.now().subtract(Duration(minutes: 3)),
                          ),
                          _buildChatMessage(
                            "I need about 15kg for my restaurant. Can you deliver today?",
                            true,
                            DateTime.now().subtract(Duration(minutes: 1)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(3.w),
                        border: Border.all(
                          color: AppTheme.lightTheme.colorScheme.outline,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Type a message...",
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 3.w),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: CustomIconWidget(
                              iconName: 'send',
                              color: AppTheme.lightTheme.colorScheme.primary,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMessage(String message, bool isMe, DateTime timestamp) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 2.w,
              backgroundImage: NetworkImage(seller["avatar"] ?? ""),
            ),
            SizedBox(width: 2.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
              decoration: BoxDecoration(
                color: isMe
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(3.w),
                border: !isMe
                    ? Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
                      )
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: isMe ? Colors.white : null,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}",
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: isMe
                          ? Colors.white.withValues(alpha: 0.7)
                          : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) ...[
            SizedBox(width: 2.w),
            CircleAvatar(
              radius: 2.w,
              backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              child: CustomIconWidget(
                iconName: 'person',
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Seller",
              style: AppTheme.lightTheme.textTheme.titleMedium,
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        _makePhoneCall(seller["phone"] ?? "+1234567890"),
                    icon: CustomIconWidget(
                      iconName: 'phone',
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text("Call Seller"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.lightTheme.colorScheme.tertiary,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openChat(context),
                    icon: CustomIconWidget(
                      iconName: 'chat',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 20,
                    ),
                    label: Text("Chat Now"),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(2.w),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'info',
                    color: AppTheme.lightTheme.colorScheme.secondary,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Response Time",
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Usually responds within 30 minutes",
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                        ),
                      ],
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
}
