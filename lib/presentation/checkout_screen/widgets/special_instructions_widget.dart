import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SpecialInstructionsWidget extends StatefulWidget {
  final String? initialInstructions;
  final Function(String) onInstructionsChanged;
  final int maxCharacters;

  const SpecialInstructionsWidget({
    super.key,
    this.initialInstructions,
    required this.onInstructionsChanged,
    this.maxCharacters = 200,
  });

  @override
  State<SpecialInstructionsWidget> createState() =>
      _SpecialInstructionsWidgetState();
}

class _SpecialInstructionsWidgetState extends State<SpecialInstructionsWidget> {
  late TextEditingController _controller;
  int _currentLength = 0;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialInstructions ?? '');
    _currentLength = _controller.text.length;
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _currentLength = _controller.text.length;
    });
    widget.onInstructionsChanged(_controller.text);
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
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'note_add',
                  color: AppTheme.lightTheme.primaryColor,
                  size: 24,
                ),
                SizedBox(width: 3.w),
                Text(
                  'Special Instructions',
                  style: AppTheme.lightTheme.textTheme.titleLarge,
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              'Add any special delivery notes or preparation requests',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: _controller,
              maxLines: 4,
              maxLength: widget.maxCharacters,
              decoration: InputDecoration(
                hintText:
                    'e.g., Please call when you arrive, Leave at front door, etc.',
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.dividerColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.dividerColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppTheme.lightTheme.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Optional delivery notes',
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '$_currentLength/${widget.maxCharacters}',
                  style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                    color: _currentLength > widget.maxCharacters * 0.9
                        ? AppTheme.warningLight
                        : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
