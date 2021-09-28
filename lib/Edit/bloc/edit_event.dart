part of 'edit_bloc.dart';

abstract class EditEvent extends Equatable {
  const EditEvent();

  @override
  List<Object> get props => [];
}

class SaveButtonPressed extends EditEvent {
  String email, password,phone,firstName,secondName;
  SaveButtonPressed( this.email ,this.password,this.firstName,this.secondName,this.phone);
}
