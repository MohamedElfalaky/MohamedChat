import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mohamed_chat/View/Screens/Contact/contact_controller.dart';

import '../../Models/user_data_model.dart';

part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit() : super(GetUsersInitial());

  getUsers() {
    try {
      emit(GetUsersLoading());
      ContactController.asyncLoadAllData().then((value) {
        if (value != null) {
          emit(GetUsersSuccess(value));
        } else {
          emit(GetUsersError());
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
