import 'package:flutter/material.dart';
import 'package:flutter_movie/peresentation/shared_widgets/custom_cached_network_image.dart';

class PhotoCard extends StatelessWidget {
  final String imgUrl;
  final Function() onTap;
  const PhotoCard({
    Key? key,
    required this.imgUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: size.width / 1.5,
          child: CustomCachedNetworkImg(imgUrl: imgUrl),
        ),
      ),
    );
  }
}
