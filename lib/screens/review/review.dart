import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class Review extends StatefulWidget {
  final dynamic product;

  const Review({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ReviewState createState() {
    return _ReviewState();
  }
}

class _ReviewState extends State<Review> {
  ReviewPageModel? _reviewPage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Fetch API
  void _loadData() async {
    final result = await Api.getReview();
    if (result.success) {
      setState(() {
        _reviewPage = ReviewPageModel.fromJson(result.data);
      });
    }
  }

  ///On refresh
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  ///On navigate write review
  void _onWriteReview() {
    Navigator.pushNamed(
      context,
      Routes.writeReview,
      arguments: widget.product,
    );
  }

  ///Build list
  Widget _buildList() {
    if (_reviewPage == null) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        itemCount: 15,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: AppCommentItem(),
          );
        },
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        itemCount: _reviewPage!.comment.length,
        itemBuilder: (context, index) {
          final item = _reviewPage!.comment[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AppCommentItem(item: item),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('review'),
        ),
        actions: <Widget>[
          AppButton(
            Translate.of(context).translate('write'),
            onPressed: _onWriteReview,
            type: ButtonType.text,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppRating(
                rate: _reviewPage?.rate,
              ),
            ),
            Expanded(child: _buildList())
          ],
        ),
      ),
    );
  }
}
