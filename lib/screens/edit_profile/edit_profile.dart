import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfile> {
  final _picker = ImagePicker();
  final _textNameController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textAddressController = TextEditingController();
  final _textWebsiteController = TextEditingController();
  final _textInfoController = TextEditingController();
  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusAddress = FocusNode();
  final _focusWebsite = FocusNode();
  final _focusInfo = FocusNode();

  XFile? _image;
  String? _validName;
  String? _validEmail;
  String? _validAddress;
  String? _validWebsite;
  String? _validInfo;

  @override
  void initState() {
    super.initState();
    _textNameController.text = 'Steve Garrett';
    _textEmailController.text = 'steve.garrett@passionui.com';
    _textAddressController.text = 'Singapore, Golden Mile';
    _textWebsiteController.text = 'passionui.com';
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On Image file
  void _onGetImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  ///On update image
  void _onUpdate() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validName = UtilValidator.validate(
        _textNameController.text,
      );
      _validEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
      _validAddress = UtilValidator.validate(
        _textAddressController.text,
      );
      _validWebsite = UtilValidator.validate(
        _textWebsiteController.text,
      );
      _validInfo = UtilValidator.validate(
        _textInfoController.text,
      );
    });
    if (_validName == null &&
        _validEmail == null &&
        _validAddress == null &&
        _validWebsite == null &&
        _validInfo == null) {
      Navigator.pop(context);
    }
  }

  ///Build avatar
  Widget _buildImage() {
    if (_image != null) {
      return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(
              File(_image!.path),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(Images.profile2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('edit_profile'),
        ),
        actions: <Widget>[
          AppButton(
            Translate.of(context).translate('confirm'),
            type: ButtonType.text,
            onPressed: _onUpdate,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: <Widget>[
                        _buildImage(),
                        IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          onPressed: _onGetImage,
                        )
                      ],
                    )
                  ],
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
                  hintText: Translate.of(context).translate('input_email'),
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
                      _focusAddress,
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
                  Translate.of(context).translate('address'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_address'),
                  errorText: _validAddress,
                  focusNode: _focusAddress,
                  textInputAction: TextInputAction.next,
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textAddressController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                      context,
                      _focusAddress,
                      _focusWebsite,
                    );
                  },
                  onChanged: (text) {
                    setState(() {
                      _validAddress = UtilValidator.validate(
                        _textAddressController.text,
                      );
                    });
                  },
                  controller: _textAddressController,
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('website'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_website'),
                  errorText: _validWebsite,
                  focusNode: _focusWebsite,
                  textInputAction: TextInputAction.next,
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textWebsiteController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                      context,
                      _focusWebsite,
                      _focusInfo,
                    );
                  },
                  onChanged: (text) {
                    setState(() {
                      _validAddress = UtilValidator.validate(
                        _textWebsiteController.text,
                      );
                    });
                  },
                  controller: _textWebsiteController,
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
    );
  }
}
