import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weather_project/Actions/user_actions.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';


part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserActions? userActions;
  RegisterBloc([this.userActions]) : super(RegisterInitial());
 
  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SignUpButtonPressed) {
      yield RegisterLoading();

      try {
        User? user =userActions!.signUp(event.email, event.password,event.phone,event.secondName,event.firstName);
        yield RegisterSucced(user: user);
      } catch (e) {
        yield RegisterFailed(message: e.toString());
      }
    }
  }
}
