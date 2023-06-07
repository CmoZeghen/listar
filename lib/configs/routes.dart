import 'package:flutter/material.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/screens/screen.dart';

class Routes {
  static const String home = "/home";
  static const String discovery = "/discovery";
  static const String wishList = "/wishList";
  static const String account = "/account";
  static const String galleryUpload = "/galleryUpload";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String forgotPassword = "/forgotPassword";
  static const String productDetail = "/productDetail";
  static const String searchHistory = "/searchHistory";
  static const String category = "/category";
  static const String notification = "/notification";
  static const String editProfile = "/editProfile";
  static const String changePassword = "/changePassword";
  static const String changeLanguage = "/changeLanguage";
  static const String contactUs = "/contactUs";
  static const String message = "/message";
  static const String chat = "/chat";
  static const String aboutUs = "/aboutUs";
  static const String gallery = "/gallery";
  static const String themeSetting = "/themeSetting";
  static const String listProduct = "/listProduct";
  static const String filter = "/filter";
  static const String review = "/review";
  static const String writeReview = "/writeReview";
  static const String location = "/location";
  static const String setting = "/setting";
  static const String fontSetting = "/fontSetting";
  static const String picker = "/picker";
  static const String gpsPicker = "/gpsPicker";
  static const String submit = "/submit";
  static const String submitSuccess = "/submitSuccess";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(
          builder: (context) {
            return SignIn(from: settings.arguments as String);
          },
          fullscreenDialog: true,
        );

      case signUp:
        return MaterialPageRoute(
          builder: (context) {
            return const SignUp();
          },
        );

      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ForgotPassword();
          },
        );

      case productDetail:
        return MaterialPageRoute(
          builder: (context) {
            switch (AppBloc.businessCubit.state) {
              case BusinessState.realEstate:
                final item = settings.arguments as ProductRealEstateModel;
                return ProductDetailRealEstate(id: item.id);

              case BusinessState.event:
                final item = settings.arguments as ProductEventModel;
                return ProductDetailEvent(id: item.id);

              case BusinessState.food:
                final item = settings.arguments as ProductFoodModel;
                return ProductDetailFood(id: item.id);

              default:
                final item = settings.arguments as ProductModel;
                if (item.viewStyle == DetailViewStyle.tab) {
                  return ProductDetailTab(id: item.id);
                }
                return ProductDetail(id: item.id);
            }
          },
        );

      case searchHistory:
        return MaterialPageRoute(
          builder: (context) {
            switch (AppBloc.businessCubit.state) {
              case BusinessState.realEstate:
                return const SearchHistoryRealEstate();
              case BusinessState.event:
                return const SearchHistoryEvent();
              case BusinessState.food:
                return const SearchHistoryFood();
              default:
                return const SearchHistory();
            }
          },
          fullscreenDialog: true,
        );

      case category:
        return MaterialPageRoute(
          builder: (context) {
            return const Category();
          },
        );

      case notification:
        return MaterialPageRoute(
          builder: (context) => const NotificationList(),
          fullscreenDialog: true,
        );

      case message:
        return MaterialPageRoute(
          builder: (context) {
            return const MessageList();
          },
        );

      case chat:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            return Chat(id: id);
          },
        );

      case editProfile:
        return MaterialPageRoute(
          builder: (context) {
            return const EditProfile();
          },
        );

      case changePassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ChangePassword();
          },
        );

      case changeLanguage:
        return MaterialPageRoute(
          builder: (context) {
            return const LanguageSetting();
          },
        );

      case contactUs:
        return MaterialPageRoute(
          builder: (context) {
            return const ContactUs();
          },
        );

      case aboutUs:
        return MaterialPageRoute(
          builder: (context) {
            return const AboutUs();
          },
        );

      case themeSetting:
        return MaterialPageRoute(
          builder: (context) {
            return const ThemeSetting();
          },
        );

      case filter:
        return MaterialPageRoute(
          builder: (context) => const Filter(),
          fullscreenDialog: true,
        );

      case review:
        final product = settings.arguments;
        return MaterialPageRoute(
          builder: (context) {
            return Review(product: product);
          },
        );

      case setting:
        return MaterialPageRoute(
          builder: (context) {
            return const Setting();
          },
        );

      case fontSetting:
        return MaterialPageRoute(
          builder: (context) {
            return const FontSetting();
          },
        );

      case writeReview:
        final product = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => WriteReview(
            product: product,
          ),
        );

      case location:
        final location = settings.arguments as LocationModel;
        return MaterialPageRoute(
          builder: (context) => Location(
            location: location,
          ),
        );

      case listProduct:
        final category = settings.arguments as CategoryModel?;
        return MaterialPageRoute(
          builder: (context) {
            switch (AppBloc.businessCubit.state) {
              case BusinessState.realEstate:
                return ListProductRealEstate(category: category);
              case BusinessState.event:
                return ListProductEvent(category: category);
              case BusinessState.food:
                return ListProductFood(category: category);
              default:
                return ListProduct(category: category);
            }
          },
        );
      case gallery:
        final product = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => Gallery(product: product),
          fullscreenDialog: true,
        );

      case picker:
        return MaterialPageRoute(
          builder: (context) {
            return Picker(
              picker: settings.arguments as PickerModel,
            );
          },
          fullscreenDialog: true,
        );

      case galleryUpload:
        return MaterialPageRoute(
          builder: (context) {
            return GalleryUpload(
              images: settings.arguments as List<ImageModel>,
            );
          },
          fullscreenDialog: true,
        );

      case gpsPicker:
        return MaterialPageRoute(
          builder: (context) {
            LocationModel? item;
            if (settings.arguments != null) {
              item = settings.arguments as LocationModel;
            }
            return GPSPicker(
              picked: item,
            );
          },
          fullscreenDialog: true,
        );

      case submit:
        return MaterialPageRoute(
          builder: (context) {
            return const Submit();
          },
          fullscreenDialog: true,
        );

      case submitSuccess:
        return MaterialPageRoute(
          builder: (context) {
            return const SubmitSuccess();
          },
          fullscreenDialog: true,
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
