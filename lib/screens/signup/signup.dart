import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  final _textIDController = TextEditingController();
  final _textPassController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _focusID = FocusNode();
  final _focusPass = FocusNode();
  final _focusEmail = FocusNode();

  bool _loading = false;
  String? _validID;
  String? _validPass;
  String? _validEmail;

  ///On sign up
  void _signUp() async {
    setState(() {
      _validID = UtilValidator.validate(
        _textIDController.text,
      );
      _validPass = UtilValidator.validate(
        _textPassController.text,
        match: _textIDController.text,
      );
      _validEmail = UtilValidator.validate(
        _textEmailController.text,
        type: ValidateType.email,
      );
    });
    if (_validID == null && _validPass == null && _validEmail == null) {
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
          Translate.of(context).translate('sign_up'),
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
                  Translate.of(context).translate('account'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_id'),
                  errorText: _validID,
                  controller: _textIDController,
                  focusNode: _focusID,
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _validID = UtilValidator.validate(
                        _textIDController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(context, _focusID, _focusPass);
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textIDController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                ),
                const SizedBox(height: 16),
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
                  textInputAction: TextInputAction.next,
                  onChanged: (text) {
                    setState(() {
                      _validPass = UtilValidator.validate(
                        _textPassController.text,
                      );
                    });
                  },
                  onSubmitted: (text) {
                    UtilOther.fieldFocusChange(
                      context,
                      _focusPass,
                      _focusEmail,
                    );
                  },
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textPassController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  obscureText: true,
                  controller: _textPassController,
                  focusNode: _focusPass,
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
                  trailing: GestureDetector(
                    dragStartBehavior: DragStartBehavior.down,
                    onTap: () {
                      _textEmailController.clear();
                    },
                    child: const Icon(Icons.clear),
                  ),
                  onSubmitted: (text) {
                    _signUp();
                  },
                  onChanged: (text) {
                    setState(() {
                      _validEmail = UtilValidator.validate(
                        _textEmailController.text,
                      );
                    });
                  },
                  controller: _textEmailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 24),
                AppButton(
                  Translate.of(context).translate('sign_up'),
                  onPressed: _signUp,
                  mainAxisSize: MainAxisSize.max,
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
