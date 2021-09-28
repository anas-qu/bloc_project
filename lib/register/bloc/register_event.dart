part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}
  
class SignUpButtonPressed extends RegisterEvent {
  String email, password,phone,firstName,secondName;
  SignUpButtonPressed( this.email ,this.password,this.firstName,this.secondName,this.phone);
}

