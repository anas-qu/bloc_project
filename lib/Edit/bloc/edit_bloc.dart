import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:weather_project/Actions/user_actions.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';


part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  UserActions? userActions;
  EditBloc([this.userActions]) : super(EditInitial());
 
  @override
  Stream<EditState> mapEventToState(
      EditEvent event,
  ) async* {
    if (event is SaveButtonPressed) {
      yield EditLoading();

      try {
        User? user = await userActions!.updateDetailsToFirestore(event.email, event.password,event.phone,event.secondName,event.firstName);
        yield EditSucced(user: user);
      } catch (e) {
        yield EditFailed(message: e.toString());
      }
    }
  }
}
