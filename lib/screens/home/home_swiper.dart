import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/widgets/app_placeholder.dart';

class HomeSwipe extends StatelessWidget {
  final double height;
  final List<ImageModel>? images;

  const HomeSwipe({
    Key? key,
    this.images,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images != null && images!.isNotEmpty) {
      return Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            images![index].image,
            fit: BoxFit.cover,
          );
        },
        autoplayDelay: 3000,
        autoplayDisableOnInteraction: false,
        autoplay: true,
        itemCount: images!.length,
        pagination: SwiperPagination(
          alignment: const Alignment(0.0, 0.4),
          builder: DotSwiperPaginationBuilder(
            activeColor: Theme.of(context).primaryColor,
            color: Colors.white,
          ),
        ),
      );
    }
    return AppPlaceholder(
      child: Container(
        color: Colors.white,
      ),
    );
  }
}
