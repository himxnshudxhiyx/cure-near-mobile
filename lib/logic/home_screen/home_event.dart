abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class UpdateHomeData extends HomeEvent {
  final String newData;
  UpdateHomeData(this.newData);
}

class GetLocationEvent extends HomeEvent {}
