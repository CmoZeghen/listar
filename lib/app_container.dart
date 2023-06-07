import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter/blocs/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/screens/screen.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:showcaseview/showcaseview.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  _AppContainerState createState() {
    return _AppContainerState();
  }
}

class _AppContainerState extends State<AppContainer> {
  String _selected = Routes.home;

  @override
  void initState() {
    super.initState();
  }

  ///check route need auth
  bool _requireAuth(String route) {
    switch (route) {
      case Routes.home:
        return false;
      default:
        return true;
    }
  }

  ///Export index stack
  int _exportIndexed(String route) {
    switch (route) {
      case Routes.home:
        return 0;
      case Routes.wishList:
        return 1;
      case Routes.message:
        return 2;
      case Routes.account:
        return 3;
      default:
        return 0;
    }
  }

  ///Force switch home when authentication state change
  void _listenAuthenticateChange(AuthenticationState authentication) async {
    if (authentication == AuthenticationState.fail && _requireAuth(_selected)) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: _selected,
      );
      if (result != null) {
        setState(() {
          _selected = result as String;
        });
      } else {
        setState(() {
          _selected = Routes.home;
        });
      }
    }
  }

  ///On change tab bottom menu and handle when not yet authenticate
  void _onItemTapped(String route) async {
    final signed = AppBloc.authenticateCubit.state != AuthenticationState.fail;
    if (!signed && _requireAuth(route)) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: route,
      );
      if (result == null) return;
    }
    setState(() {
      _selected = route;
    });
  }

  ///On handle submit post
  void _onSubmit(bool authenticated) async {
    if (!authenticated) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: Routes.submit,
      );
      if (result == null) return;
    }
    Navigator.pushNamed(context, Routes.submit);
  }

  ///Home Screen For Your Business
  Widget _homeForBusiness(BusinessState business) {
    switch (business) {
      case BusinessState.realEstate:
        return const HomeRealEstate();
      case BusinessState.event:
        return const HomeEvent();
      case BusinessState.food:
        return const HomeFood();
      default:
        return const Home();
    }
  }

  ///WishList Screen For Your Business
  Widget _wishListForBusiness(BusinessState business) {
    switch (business) {
      case BusinessState.realEstate:
        return const WishListRealEstate();
      case BusinessState.event:
        return const WishListEvent();
      case BusinessState.food:
        return const WishListFood();
      default:
        return const WishList();
    }
  }

  ///Build bottom menu
  Widget _buildBottomMenu() {
    return BottomAppBar(
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenuItem(Routes.home),
            _buildMenuItem(Routes.wishList),
            const SizedBox(width: 56),
            _buildMenuItem(Routes.message),
            _buildMenuItem(Routes.account),
          ],
        ),
      ),
    );
  }

  ///Build Item Menu
  Widget _buildMenuItem(String route) {
    Color? color;
    String title = 'home';
    IconData iconData = Icons.help_outline;
    switch (route) {
      case Routes.home:
        iconData = Icons.home_outlined;
        title = 'home';
        break;
      case Routes.message:
        iconData = Icons.chat_outlined;
        title = 'message';
        break;
      case Routes.wishList:
        iconData = Icons.bookmark_outline;
        title = 'wish_list';
        break;
      case Routes.account:
        iconData = Icons.account_circle_outlined;
        title = 'account';
        break;
      default:
        iconData = Icons.home_outlined;
        title = 'home';
        break;
    }
    if (route == _selected) {
      color = Theme.of(context).primaryColor;
    }
    return IconButton(
      onPressed: () {
        _onItemTapped(route);
      },
      padding: EdgeInsets.zero,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: color,
          ),
          const SizedBox(height: 2),
          Text(
            Translate.of(context).translate(title),
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontSize: 10,
                  color: color,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const centerDocked = FloatingActionButtonLocation.centerDocked;
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, authentication) async {
        _listenAuthenticateChange(authentication);
      },
      child: BlocBuilder<BusinessCubit, BusinessState>(
        builder: (context, business) {
          return BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, authentication) {
              final authenticated = authentication != AuthenticationState.fail;
              return Scaffold(
                body: IndexedStack(
                  index: _exportIndexed(_selected),
                  children: <Widget>[
                    _homeForBusiness(business),
                    _wishListForBusiness(business),
                    const MessageList(),
                    const Profile()
                  ],
                ),
                bottomNavigationBar: _buildBottomMenu(),
                floatingActionButton: Showcase(
                  key: Application.globalKey['submit']!,
                  description: Translate.of(context).translate(
                    'submit_listing',
                  ),
                  showArrow: true,
                  targetShapeBorder: const CircleBorder(),
                  targetPadding: const EdgeInsets.all(4),
                  child: FloatingActionButton(
                    heroTag: "submit",
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      _onSubmit(authenticated);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                floatingActionButtonLocation: centerDocked,
              );
            },
          );
        },
      ),
    );
  }
}
