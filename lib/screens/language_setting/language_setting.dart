import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({Key? key}) : super(key: key);

  @override
  _LanguageSettingState createState() {
    return _LanguageSettingState();
  }
}

class _LanguageSettingState extends State<LanguageSetting> {
  final _textLanguageController = TextEditingController();

  List<Locale> _listLanguage = AppLanguage.supportLanguage;
  Locale _languageSelected = AppBloc.languageCubit.state;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textLanguageController.dispose();
    super.dispose();
  }

  ///On filter language
  void _onFilter(String text) {
    if (text.isEmpty) {
      setState(() {
        _listLanguage = AppLanguage.supportLanguage;
      });
      return;
    }
    setState(() {
      _listLanguage = _listLanguage.where(((item) {
        return AppLanguage.getGlobalLanguageName(item.languageCode)
            .toUpperCase()
            .contains(text.toUpperCase());
      })).toList();
    });
  }

  ///On change language
  void _changeLanguage() async {
    UtilOther.hiddenKeyboard(context);
    AppBloc.languageCubit.onUpdate(_languageSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('change_language'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppTextInput(
                hintText: Translate.of(context).translate('search'),
                controller: _textLanguageController,
                onChanged: _onFilter,
                onSubmitted: _onFilter,
                trailing: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: () {
                    _textLanguageController.clear();
                  },
                  child: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) {
                  Widget? trailing;
                  final item = _listLanguage[index];
                  if (item == _languageSelected) {
                    trailing = Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    );
                  }
                  return AppListTitle(
                    title: AppLanguage.getGlobalLanguageName(
                      item.languageCode,
                    ),
                    trailing: trailing,
                    onPressed: () {
                      setState(() {
                        _languageSelected = item;
                      });
                    },
                    border: item != _listLanguage.last,
                  );
                },
                itemCount: _listLanguage.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(
                Translate.of(context).translate('confirm'),
                mainAxisSize: MainAxisSize.max,
                onPressed: _changeLanguage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
