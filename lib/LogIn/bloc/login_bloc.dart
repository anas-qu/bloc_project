import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_project/Actions/user_actions.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserActions? userActions;
  LoginBloc([this.userActions]) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
    if (event is SignInButtonPressed) {
      yield LoginLoading();

      try {
        User? user = await userActions!.signIn(event.email, event.password);
        yield LoginSucced(user: user);
      } catch (e) {
        yield LoginFailed(message: e.toString());
      }
    }
  }
}