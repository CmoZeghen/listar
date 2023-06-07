import 'dart:async';

import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/utils/utils.dart';

class Api {
  ///URL API
  static const String loginURL = "/jwt-auth/v1/token";

  ///Login api
  static Future<dynamic> login(params) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await UtilData.login();
    return ResultApiModel.fromJson(result);
  }

  ///Validate token valid
  static Future<dynamic> validateToken() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await UtilData.validateToken();
    return ResultApiModel.fromJson(result);
  }

  ///Get Category
  static Future<dynamic> getCategory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await UtilData.getCategory();
    return ResultApiModel.fromJson(result);
  }

  ///Get About Us
  static Future<dynamic> getAboutUs() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await UtilData.getAboutUs();
    return ResultApiModel.fromJson(result);
  }

  ///Get Home
  static Future<dynamic> getHome() async {
    await Future.delayed(const Duration(milliseconds: 500));
    Map<String, dynamic> result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getHomeRealEstate();
        break;
      case BusinessState.event:
        result = await UtilData.getHomeEvent();
        break;
      case BusinessState.food:
        result = await UtilData.getHomeFood();
        break;
      default:
        result = await UtilData.getHomeBasic();
    }
    return ResultApiModel.fromJson(result);
  }

  ///Get Messages
  static Future<dynamic> getMessage() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await UtilData.getMessage();
    return ResultApiModel.fromJson(result);
  }

  ///Get Detail Messages
  static Future<dynamic> getDetailMessage({required int id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await UtilData.getDetailMessage(id);
    return ResultApiModel.fromJson(result);
  }

  ///Get Notification
  static Future<dynamic> getNotification() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await UtilData.getNotification();
    return ResultApiModel.fromJson(result);
  }

  ///Get ProductDetail and Product Detail Tab
  static Future<dynamic> getProductDetail({required int id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    Map<String, dynamic> result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getProductDetailRealEstate(
          id: id,
          jsonResultApi: true,
        );
        break;
      case BusinessState.event:
        result = await UtilData.getProductDetailEvent(
          id: id,
          jsonResultApi: true,
        );
        break;
      case BusinessState.food:
        result = await UtilData.getProductDetailFood(
          id: id,
          jsonResultApi: true,
        );
        break;
      default:
        result = await UtilData.getProductDetailBasic(
          id: id,
          jsonResultApi: true,
        );
    }
    return ResultApiModel.fromJson(result);
  }

  ///Get History Search
  static Future<dynamic> getHistorySearch() async {
    await Future.delayed(const Duration(milliseconds: 500));
    Map<String, dynamic> result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getHistorySearchRealEstate();
        break;
      case BusinessState.event:
        result = await UtilData.getHistorySearchEvent();
        break;
      case BusinessState.food:
        result = await UtilData.getHistorySearchFood();
        break;
      default:
        result = await UtilData.getHistorySearchBasic();
    }
    return ResultApiModel.fromJson(result);
  }

  ///Get Wish List
  static Future<dynamic> getWishList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    Map<String, dynamic> result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getWishListRealEstate();
        break;
      case BusinessState.event:
        result = await UtilData.getWishListEvent();
        break;
      case BusinessState.food:
        result = await UtilData.getWishListFood();
        break;
      default:
        result = await UtilData.getWishList();
    }
    return ResultApiModel.fromJson(result);
  }

  ///On Search
  static Future<dynamic> onSearchData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    Map<String, dynamic> result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getProductRealEstate();
        break;
      case BusinessState.event:
        result = await UtilData.getProductEvent();
        break;
      case BusinessState.food:
        result = await UtilData.getProductFood();
        break;
      default:
        result = await UtilData.getProductBasic();
    }
    return ResultApiModel.fromJson(result);
  }

  ///Get Location List
  static Future<dynamic> getLocationList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await UtilData.getLocationList();
    return ResultApiModel.fromJson(result);
  }

  ///Get Product List
  static Future<dynamic> getProduct() async {
    await Future.delayed(const Duration(milliseconds: 500));
    Map<String, dynamic> result;
    switch (AppBloc.businessCubit.state) {
      case BusinessState.realEstate:
        result = await UtilData.getProductRealEstate();
        break;
      case BusinessState.event:
        result = await UtilData.getProductEvent();
        break;
      case BusinessState.food:
        result = await UtilData.getProductFood();
        break;
      default:
        result = await UtilData.getProductBasic();
    }
    return ResultApiModel.fromJson(result);
  }

  ///Get Review
  static Future<dynamic> getReview() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await UtilData.getReview();
    return ResultApiModel.fromJson(result);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
