import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  final _textPassController = TextEditingController();
  final _textRePassController = TextEditingController();
  final _focusPass = FocusNode();
  final _focusRePass = FocusNode();

  bool _loading = false;
  String? _validPass;
  String? _validRePass;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On change password
  void _onChangePassword() async {
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validPass = UtilValidator.validate(
        _textPassController.text,
      );
      _validRePass = UtilValidator.validate(
        _textRePassController.text,
        match: _textPassController.text,
      );
    });
    if (_validPass == null && _validRePass == null) {
      setState(() {
        _loading = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('change_password'),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Translate.of(context).translate('password'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'input_your_password',
                  ),
                  errorText: _validPass,
                  focusNode: _focusPass,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textPassController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                      context,
                      _focusPass,
                      _focusRePass,
                    );
                  },
                  onChanged: (text) {
                    setState(() {
                      _validPass = UtilValidator.validate(
                        _textPassController.text,
                      );
                    });
                  },
                  controller: _textPassController,
                ),
                const SizedBox(height: 8),
                Text(
                  Translate.of(context).translate('confirm_password'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate(
                    'confirm_your_password',
                  ),
                  errorText: _validRePass,
                  focusNode: _focusRePass,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textRePassController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  onSubmitted: (text) {
                    _onChangePassword();
                  },
                  onChanged: (text) {
                    setState(() {
                      _validRePass = UtilValidator.validate(
                        _textRePassController.text,
                      );
                    });
                  },
                  controller: _textRePassController,
                ),
                const SizedBox(height: 16),
                AppButton(
                  Translate.of(context).translate('confirm'),
                  mainAxisSize: MainAxisSize.max,
                  onPressed: _onChangePassword,
                  loading: _loading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
