import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/screens/home/home_category_item.dart';
import 'package:listar_flutter/utils/utils.dart';

class HomeCategoryList extends StatelessWidget {
  final List<CategoryModel>? category;
  final Function(CategoryModel)? onCategory;
  final VoidCallback? onCategoryList;

  const HomeCategoryList({
    Key? key,
    this.category,
    this.onCategory,
    this.onCategoryList,
  }) : super(key: key);

  Widget _buildContent(BuildContext context) {
    if (category == null) {
      return Wrap(
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: List.generate(8, (index) => index).map(
          (item) {
            return const HomeCategoryItem();
          },
        ).toList(),
      );
    }
    return Wrap(
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: category!.map(
        (item) {
          return HomeCategoryItem(
            item: item,
            onPressed: () {
              onCategory!(item);
            },
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    Translate.of(context).translate('explore_product'),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: onCategoryList,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        Translate.of(context).translate('view_list'),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: _buildContent(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
