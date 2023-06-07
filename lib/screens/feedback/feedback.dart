import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class WriteReview extends StatefulWidget {
  final dynamic product;

  const WriteReview({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _WriteReviewState createState() {
    return _WriteReviewState();
  }
}

class _WriteReviewState extends State<WriteReview> {
  final _textTitleController = TextEditingController();
  final _focusReviewController = TextEditingController();

  final _focusTitle = FocusNode();
  final _focusReview = FocusNode();

  String? _validTitle;
  String? _validReview;
  double _rate = 5;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On send
  void _onSend() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validTitle = UtilValidator.validate(
        _textTitleController.text,
      );
      _validReview = UtilValidator.validate(
        _focusReviewController.text,
      );
    });
    if (_validTitle == null && _validReview == null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('feedback'),
        ),
        actions: <Widget>[
          AppButton(
            Translate.of(context).translate('send'),
            type: ButtonType.text,
            onPressed: _onSend,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(widget.product.author!.image),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              RatingBar.builder(
                initialRating: _rate,
                minRating: 1,
                allowHalfRating: true,
                unratedColor: Colors.amber.withAlpha(100),
                itemCount: 5,
                itemSize: 28.0,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  setState(() {
                    _rate = value;
                  });
                },
              ),
              const SizedBox(height: 4),
              Text(
                Translate.of(context).translate('tap_rate'),
                style: Theme.of(context).textTheme.caption,
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Translate.of(context).translate('title'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: Translate.of(context).translate(
                      'input_title',
                    ),
                    errorText: _validTitle,
                    focusNode: _focusTitle,
                    textInputAction: TextInputAction.next,
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        _textTitleController.clear();
                      },
                      child: const Icon(Icons.clear),
                    ),
                    onSubmitted: (text) {
                      UtilOther.fieldFocusChange(
                        context,
                        _focusTitle,
                        _focusReview,
                      );
                    },
                    onChanged: (text) {
                      setState(() {
                        _validTitle = UtilValidator.validate(
                          _textTitleController.text,
                        );
                      });
                    },
                    controller: _textTitleController,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Translate.of(context).translate('description'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  AppTextInput(
                    hintText: Translate.of(context).translate(
                      'input_feedback',
                    ),
                    errorText: _validReview,
                    focusNode: _focusReview,
                    maxLines: 5,
                    trailing: GestureDetector(
                      dragStartBehavior: DragStartBehavior.down,
                      onTap: () {
                        _focusReviewController.clear();
                      },
                      child: const Icon(Icons.clear),
                    ),
                    onChanged: (text) {
                      setState(() {
                        _validReview = UtilValidator.validate(
                          _focusReviewController.text,
                        );
                      });
                    },
                    controller: _focusReviewController,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
