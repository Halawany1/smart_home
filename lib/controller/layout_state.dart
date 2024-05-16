part of 'layout_cubit.dart';

@immutable
sealed class LayoutState {}

 class LayoutInitial extends LayoutState {}

class LoadingGetData extends LayoutState {}

 class SuccessGetData extends LayoutState {}

 class SuccessUpdateBuzzerState extends LayoutState {}

 class FailedUpdateBuzzerState extends LayoutState {}

