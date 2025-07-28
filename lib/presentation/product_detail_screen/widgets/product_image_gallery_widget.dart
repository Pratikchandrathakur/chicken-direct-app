import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProductImageGalleryWidget extends StatefulWidget {
  final List<String> imageUrls;
  final String heroTag;

  const ProductImageGalleryWidget({
    Key? key,
    required this.imageUrls,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<ProductImageGalleryWidget> createState() =>
      _ProductImageGalleryWidgetState();
}

class _ProductImageGalleryWidgetState extends State<ProductImageGalleryWidget> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  TransformationController _transformationController =
      TransformationController();

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      child: Stack(
        children: [
          Hero(
            tag: widget.heroTag,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.imageUrls.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  transformationController: _transformationController,
                  panEnabled: true,
                  scaleEnabled: true,
                  minScale: 1.0,
                  maxScale: 3.0,
                  child: Container(
                    width: double.infinity,
                    child: CustomImageWidget(
                      imageUrl: widget.imageUrls[index],
                      width: double.infinity,
                      height: 40.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          if (widget.imageUrls.length > 1)
            Positioned(
              bottom: 2.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imageUrls.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                    width: _currentIndex == index ? 3.w : 2.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? AppTheme.lightTheme.colorScheme.primary
                          : AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
