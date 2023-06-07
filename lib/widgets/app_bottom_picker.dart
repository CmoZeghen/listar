import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class AppBottomPicker extends StatelessWidget {
  final PickerModel picker;

  const AppBottomPicker({
    Key? key,
    required this.picker,
  }) : super(key: key);

  ///Build leading for image or icon
  Widget? buildLeading(BuildContext context, item) {
    Widget? result;
    try {
      if (item.image != null) {
        return Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(item.image),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
          ],
        );
      }
    } catch (e) {
      result = Container();
    }
    try {
      if (item.icon != null) {
        return Icon(item.icon);
      }
    } catch (e) {
      result = Container();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Column(
                  children: picker.data.map((item) {
                    final title = Translate.of(context).translate(item.title);
                    Widget? trailing;
                    Widget? leading = buildLeading(context, item);

                    if (picker.selected.contains(item)) {
                      trailing = Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      );
                    }
                    if (item == picker.data.last) {
                      return AppListTitle(
                        title: title,
                        leading: leading,
                        trailing: trailing,
                        border: false,
                        onPressed: () {
                          Navigator.pop(context, item);
                        },
                      );
                    }
                    return AppListTitle(
                      title: Translate.of(context).translate(title),
                      leading: leading,
                      trailing: trailing,
                      onPressed: () {
                        Navigator.pop(context, item);
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
