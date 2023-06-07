import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Gallery extends StatefulWidget {
  final dynamic product;

  const Gallery({Key? key, required this.product}) : super(key: key);

  @override
  _GalleryState createState() {
    return _GalleryState();
  }
}

class _GalleryState extends State<Gallery> {
  final _controller = SwiperController();
  final _listController = ScrollController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _listController.dispose();
    _controller.dispose();
    super.dispose();
  }

  ///On Process index change
  void _onChange(int index) {
    setState(() {
      _index = index;
    });
    final currentOffset = (index + 1) * 90.0;
    final widthDevice = MediaQuery.of(context).size.width;

    ///Animate scroll to Overflow offset
    if (currentOffset > widthDevice) {
      _listController.animateTo(
        currentOffset - widthDevice,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      ///Move to Start offset when index not overflow
      _listController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  ///On preview photo
  void _onPreviewPhoto(int initialPage) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      builder: (BuildContext context) {
        return PhotoViewGallery.builder(
          loadingBuilder: (context, event) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (context, index) {
            final String item = widget.product.photo[index].image;
            return PhotoViewGalleryPageOptions(
              imageProvider: AssetImage(item),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 1.1,
            );
          },
          itemCount: widget.product.photo.length,
          pageController: PageController(initialPage: initialPage),
          scrollDirection: Axis.horizontal,
        );
      },
    );
  }

  ///On select image
  void _onSelectImage(int index) {
    _controller.move(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Swiper(
                controller: _controller,
                onIndexChanged: _onChange,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onPreviewPhoto(index);
                    },
                    child: Image.asset(
                      widget.product.photo[index].image,
                      fit: BoxFit.contain,
                    ),
                  );
                },
                itemCount: widget.product.photo.length,
                pagination: SwiperPagination(
                  alignment: const Alignment(0.0, 0.9),
                  builder: DotSwiperPaginationBuilder(
                    activeColor: Theme.of(context).primaryColor,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.product.title,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    "${_index + 1}/${widget.product.photo.length}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              height: 70,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListView.builder(
                controller: _listController,
                padding: const EdgeInsets.only(right: 16),
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.photo.length,
                itemBuilder: (context, index) {
                  final item = widget.product.photo[index];
                  Color borderColor = Theme.of(context).dividerColor;
                  if (index == _index) {
                    borderColor = Theme.of(context).primaryColor;
                  }
                  return GestureDetector(
                    onTap: () {
                      _onSelectImage(index);
                    },
                    child: Container(
                      width: 70,
                      margin: const EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: AssetImage(item.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
