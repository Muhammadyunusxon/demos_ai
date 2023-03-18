part of 'home_cubit.dart';

class HomeState {
  UserModel? user;
  HomeState({this.user});

  HomeState copyWith({UserModel? user}){
    return HomeState(user: user ?? this.user);
  }
}
