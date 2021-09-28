part of 'edit_bloc.dart';

abstract class EditState extends Equatable {
  const EditState();

  @override
  List<Object> get props => [];
}

class EditInitial extends EditState {}

class EditLoading extends EditState {}

class EditSucced extends EditState {
  User? user;
  EditSucced({required this.user});
}
  
class EditFailed extends EditState {
  String message;
  EditFailed({required this.message});
}
