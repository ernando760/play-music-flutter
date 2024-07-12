import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingBaseState extends BaseState {}

class SuccessBaseState<T> extends BaseState {
  final T data;

  SuccessBaseState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FailureBaseState extends BaseState {
  final String messageErro;

  FailureBaseState({required this.messageErro});

  @override
  List<Object?> get props => [messageErro];
}
