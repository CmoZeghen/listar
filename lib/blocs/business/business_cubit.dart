import 'package:bloc/bloc.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/utils/utils.dart';

enum BusinessState { basic, realEstate, food, event }

class BusinessCubit extends Cubit<BusinessState> {
  BusinessCubit() : super(BusinessState.basic);

  Future<void> onChangeBusiness(BusinessState business) async {
    ///Preference save
    await Preferences.setString(
      Preferences.business,
      business.toString().split('.').last,
    );

    emit(business);
  }
}
