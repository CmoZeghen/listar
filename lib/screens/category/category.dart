import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/category_page_model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() {
    return _CategoryState();
  }
}

class _CategoryState extends State<Category> {
  final _textController = TextEditingController();

  CategoryType _type = CategoryType.full;
  CategoryPageModel? _categoryPage;
  String _keyword = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On clear search
  Future<void> _onClearTapped() async {
    _textController.text = '';
    setState(() {
      _keyword = _textController.text;
    });
  }

  ///On change mode view
  void _onChangeModeView() {
    switch (_type) {
      case CategoryType.full:
        setState(() {
          _type = CategoryType.icon;
        });
        break;
      case CategoryType.icon:
        setState(() {
          _type = CategoryType.full;
        });
        break;
      default:
        break;
    }
  }

  ///Fetch API
  void _loadData() async {
    final result = await Api.getCategory();
    if (result.success) {
      setState(() {
        _categoryPage = CategoryPageModel.fromJson(result.data);
      });
    }
  }

  ///On refresh list
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  ///On navigate list product
  void _onProductList(CategoryModel item) {
    Navigator.pushNamed(
      context,
      Routes.listProduct,
      arguments: item,
    );
  }

  ///On Search Category
  void _onSearch(String text) {
    setState(() {
      _keyword = text;
    });
  }

  ///Build UI list
  Widget _buildList() {
    ///Loading
    if (_categoryPage == null) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: List.generate(8, (index) => index).length,
        itemBuilder: (context, index) {
          return AppCategory(type: _type);
        },
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(),
          );
        },
      );
    }

    final data = _categoryPage!.category.where(((item) {
      if (_keyword.isEmpty) {
        return true;
      }
      return item.title.toUpperCase().contains(_keyword.toUpperCase());
    })).toList();

    ///Empty
    if (data.isEmpty) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.sentiment_satisfied),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                Translate.of(context).translate('category_not_found'),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );
    }

    ///List
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return AppCategory(
            type: _type,
            item: item,
            onPressed: () {
              _onProductList(item);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    IconData iconView = Icons.view_agenda_outlined;
    if (_type == CategoryType.icon) {
      iconView = Icons.view_headline_outlined;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('category')),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              iconView,
            ),
            onPressed: _onChangeModeView,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16),
              AppTextInput(
                hintText: Translate.of(context).translate('search'),
                trailing: GestureDetector(
                  dragStartBehavior: DragStartBehavior.down,
                  onTap: _onClearTapped,
                  child: const Icon(Icons.clear),
                ),
                controller: _textController,
                onSubmitted: _onSearch,
                onChanged: _onSearch,
              ),
              const SizedBox(height: 8),
              Expanded(child: _buildList())
            ],
          ),
        ),
      ),
    );
  }
}
