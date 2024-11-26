import 'package:flutter_bloc/flutter_bloc.dart';

class FabState {
  FabState({required this.isFabVisible});
  final bool isFabVisible;
}

class FabCubit extends Cubit<FabState> {
  FabCubit() : super(FabState(isFabVisible: true));


  void updateFabVisibility({required bool isVisible}) {
    emit(FabState(isFabVisible: isVisible));
  }
}
