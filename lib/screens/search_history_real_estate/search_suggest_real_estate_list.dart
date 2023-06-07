import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class SuggestionList extends StatelessWidget {
  final String query;
  final Function(ProductRealEstateModel) onProductDetail;

  const SuggestionList({
    Key? key,
    required this.query,
    required this.onProductDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: BlocBuilder<SearchCubit, dynamic>(
        builder: (context, data) {
          if (query.isEmpty) {
            return Container();
          }
          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (data.isEmpty) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.sentiment_satisfied),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      Translate.of(context).translate('data_not_found'),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AppProductRealEstateItem(
                  onPressed: () {
                    onProductDetail(item);
                  },
                  item: item,
                  type: ProductViewType.small,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
