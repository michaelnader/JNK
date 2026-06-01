import 'package:flutter/material.dart';

import '../../app/constants.dart';
import 'scene.dart';

/// Round monochrome restaurant photo avatar.
class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.photoAsset,
    this.size = 40,
    this.ring = false,
  });

  final String photoAsset;
  final double size;
  final bool ring;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: ring
            ? Border.all(color: AppColors.softCream, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(child: MonoPhoto(asset: photoAsset)),
    );
  }
}
