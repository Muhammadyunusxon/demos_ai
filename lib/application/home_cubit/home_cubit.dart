import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../infrastructure/models/user_model.dart';
import '../../infrastructure/services/local_storage.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  getUserInfo() async {
    var id = await LocalStore.getDocId();
    var res = await firestore.collection("users").doc(id).get();
    emit(state.copyWith(
        user: UserModel.fromJson(data: res.data(), docId: res.id)));
    checkDate();
  }

  checkDate() async {
    if (DateTime.now().isAfter(DateTime.parse(state.user?.joinTime ?? '')
        .add(const Duration(days: 1)))) {
      var res = await firestore.collection("limit").get();
      state.user?.dailyLimit = res.docs.first.data()["daily"];
      emit(state.copyWith(user: state.user));
    } else if (DateTime.now().isAfter(DateTime.parse(state.user?.joinTime ?? '')
        .add(const Duration(days: 30)))) {
      var res = await firestore.collection("limit").get();
      state.user?.extraLimit =
          state.user?.extraLimit ?? 0 + res.docs.first.data()["monthly"] as int;
      emit(state.copyWith(user: state.user));
    }
  }
}
