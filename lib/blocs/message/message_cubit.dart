import 'package:bloc/bloc.dart';

class MessageCubit extends Cubit<String?> {
  MessageCubit() : super(null);

  void onShow(String message) {
    emit(message);
  }
}
