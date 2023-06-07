import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  ContactUsState createState() => ContactUsState();
}

class ContactUsState extends State<ContactUs> {
  final _initPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final _textNameController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textInfoController = TextEditingController();
  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusInfo = FocusNode();

  String? _validName;
  String? _validEmail;
  String? _validInfo;

  @override
  void initState() {
    super.initState();
    _textNameController.text = 'Steve Garrett';
    _textEmailController.text = 'steve.garrett@passionui.com';
    _textInfoController.text = "Hi everyone";
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On send
  void _onSend() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validName = UtilValidator.validate(
        _textNameController.text,
      );
      _validEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
      _validInfo = UtilValidator.validate(
        _textInfoController.text,
      );
    });
    if (_validName == null && _validEmail == null && _validInfo == null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('contact_us')),
        actions: <Widget>[
          AppButton(
            Translate.of(context).translate('send'),
            type: ButtonType.text,
            onPressed: _onSend,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 250,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: GoogleMap(
                          initialCameraPosition: _initPosition,
                          myLocationButtonEnabled: false,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        Translate.of(context).translate('name'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppTextInput(
                        hintText: Translate.of(context).translate('input_name'),
                        errorText: _validName,
                        focusNode: _focusName,
                        textInputAction: TextInputAction.next,
                        trailing: GestureDetector(
                          dragStartBehavior: DragStartBehavior.down,
                          onTap: () {
                            _textNameController.clear();
                          },
                          child: const Icon(Icons.clear),
                        ),
                        onSubmitted: (text) {
                          UtilOther.fieldFocusChange(
                            context,
                            _focusName,
                            _focusEmail,
                          );
                        },
                        onChanged: (text) {
                          setState(() {
                            _validName = UtilValidator.validate(
                              _textNameController.text,
                            );
                          });
                        },
                        controller: _textNameController,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        Translate.of(context).translate('email'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppTextInput(
                        hintText: Translate.of(context).translate(
                          'input_email',
                        ),
                        errorText: _validEmail,
                        focusNode: _focusEmail,
                        textInputAction: TextInputAction.next,
                        trailing: GestureDetector(
                          dragStartBehavior: DragStartBehavior.down,
                          onTap: () {
                            _textEmailController.clear();
                          },
                          child: const Icon(Icons.clear),
                        ),
                        onSubmitted: (text) {
                          UtilOther.fieldFocusChange(
                            context,
                            _focusEmail,
                            _focusInfo,
                          );
                        },
                        onChanged: (text) {
                          setState(() {
                            _validEmail = UtilValidator.validate(
                              _textEmailController.text,
                              type: ValidateType.email,
                            );
                          });
                        },
                        controller: _textEmailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        Translate.of(context).translate('information'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      AppTextInput(
                        hintText: Translate.of(context).translate(
                          'input_information',
                        ),
                        errorText: _validInfo,
                        focusNode: _focusInfo,
                        maxLines: 5,
                        trailing: GestureDetector(
                          dragStartBehavior: DragStartBehavior.down,
                          onTap: () {
                            _textInfoController.clear();
                          },
                          child: const Icon(Icons.clear),
                        ),
                        onSubmitted: (text) {
                          _onSend();
                        },
                        onChanged: (text) {
                          setState(() {
                            _validInfo = UtilValidator.validate(
                              _textInfoController.text,
                            );
                          });
                        },
                        controller: _textInfoController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
