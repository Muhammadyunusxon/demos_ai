part of 'maps_cubit.dart';

class MapsState {
  String? searchText;
  Position? currentPosition;
  Set<Marker>? setOfMarker = {};
  String? mapTheme;
  int dailyLimit;
  int extraLimit;
  String info;
  bool isLoading;

  MapsState({
    this.searchText,
    this.currentPosition,
    this.setOfMarker,
    this.mapTheme,
    this.dailyLimit = 0,
    this.extraLimit = 0,
    this.info = '',
    this.isLoading = false,
  });

  MapsState copyWith({
    String? searchText,
    Position? currentPosition,
    Set<Marker>? setOfMarker,
    String? mapTheme,
    int? dailyLimit,
    int? extraLimit,
    String? info,
    bool? isLoading,
  }) {
    return MapsState(
      searchText: searchText ?? this.searchText,
      currentPosition: currentPosition ?? this.currentPosition,
      setOfMarker: setOfMarker ?? this.setOfMarker,
      mapTheme: mapTheme ?? this.mapTheme,
      dailyLimit: dailyLimit ?? this.dailyLimit,
      extraLimit: extraLimit ?? this.extraLimit,
      info: info ?? this.info,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
