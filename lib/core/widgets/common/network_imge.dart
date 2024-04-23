import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../../utils/constants/image_path.dart';
import '../shimmer/image_shimmer.dart';

class SkyNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final String errorImage;
  final Widget? placeHolder;
  final double borderRadius;
  const SkyNetworkImage({
    super.key,
    this.borderRadius = 0,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.height,
    this.width,
    this.errorImage = ImagePath.placeHolder,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: boxFit,
        cacheKey: imageUrl,
        height: height,
        width: width,
        placeholder: (context, url) => placeHolder ?? const ImageShimmer(),
        errorWidget: (context, url, error) => Image.asset(
          errorImage,
          fit: boxFit,
        ),
      ),
    );
  }
}
