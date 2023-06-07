import 'package:flutter/material.dart';
import 'package:listar_flutter/utils/utils.dart';

class InputMore extends StatefulWidget {
  final Function(String) onSend;
  const InputMore({
    Key? key,
    required this.onSend,
  }) : super(key: key);

  @override
  _InputMoreState createState() {
    return _InputMoreState();
  }
}

class _InputMoreState extends State<InputMore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onFilePicker() async {}

  void _onLocationPicker() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      alignment: Alignment.topLeft,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          FractionallySizedBox(
            widthFactor: 0.25,
            child: Column(
              children: [
                InkWell(
                  onTap: _onFilePicker,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: Icon(
                      Icons.file_copy_outlined,
                      size: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Translate.of(context).translate('file'),
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.25,
            child: Column(
              children: [
                InkWell(
                  onTap: _onLocationPicker,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Translate.of(context).translate('location'),
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.25,
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: Icon(
                      Icons.contact_mail_outlined,
                      size: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Translate.of(context).translate('contact'),
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.25,
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: Icon(
                      Icons.favorite_border_rounded,
                      size: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Translate.of(context).translate('favorite'),
                    style: Theme.of(context).textTheme.button,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
