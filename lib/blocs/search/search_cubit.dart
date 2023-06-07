import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/models/model.dart';

class SearchCubit extends Cubit<dynamic> {
  SearchCubit() : super(null);

  Timer? _timer;

  void onSearch(String keyword) async {
    emit(null);
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () {
      _fetchData(keyword);
    });
  }

  void _fetchData(String keyword) async {
    if (keyword.isNotEmpty) {
      final result = await Api.onSearchData();
      if (result.success) {
        switch (AppBloc.businessCubit.state) {
          case BusinessState.realEstate:
            List<ProductRealEstateModel> list =
                result.data.map<ProductRealEstateModel>((item) {
              return ProductRealEstateModel.fromJson(item);
            }).toList();
            emit(list.where((item) {
              return item.title.toUpperCase().contains(keyword.toUpperCase());
            }).toList());

            break;
          case BusinessState.event:
            List<ProductEventModel> list =
                result.data.map<ProductEventModel>((item) {
              return ProductEventModel.fromJson(item);
            }).toList();
            emit(list.where((item) {
              return item.title.toUpperCase().contains(keyword.toUpperCase());
            }).toList());

            break;
          case BusinessState.food:
            List<ProductFoodModel> list =
                result.data.map<ProductFoodModel>((item) {
              return ProductFoodModel.fromJson(item);
            }).toList();
            emit(list.where((item) {
              return item.title.toUpperCase().contains(keyword.toUpperCase());
            }).toList());

            break;
          default:
            List<ProductModel> list = result.data.map<ProductModel>((item) {
              return ProductModel.fromJson(item);
            }).toList();
            emit(list.where((item) {
              return item.title.toUpperCase().contains(keyword.toUpperCase());
            }).toList());
        }
      }
    }
  }
}
