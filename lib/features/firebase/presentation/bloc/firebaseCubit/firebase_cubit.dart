import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:intern_project/features/firebase/domain/usecase/get_unit_list_usecase.dart';
import 'package:intern_project/features/firebase/domain/usecase/get_user_data_usecase.dart';

part 'firebase_state.dart';

class FirebaseCubit extends Cubit<FirebaseState> {
  final GetUnitListUsecase _getUnitListUsecase;
  final GetUserDataUsecase _getUserDataUsecase;

  FirebaseCubit(this._getUnitListUsecase, this._getUserDataUsecase)
      : super(FirebaseInitial());

  Future<void> appInit() async {
    emit(FirebaseLoading());
    _getUserDataUsecase();
    _getUnitListUsecase();

    emit(DataFetched());
  }
}
