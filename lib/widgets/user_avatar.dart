import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/widgets/loading_indicator.dart';

class UserAvatar extends StatelessWidget {
  final String photoUrl;

  const UserAvatar(
    this.photoUrl, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: photoUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: 52.r,
          height: 52.r,
          foregroundDecoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(2.0, 7.0),
                blurRadius: 7.0,
              ),
            ],
          ),
        );
      },
      placeholder: (_, __) => const LoadingIndicator(),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
    );
  }
}
