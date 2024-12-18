abstract class TabBarState {}

class TabBarInitial extends TabBarState {}

class TabBarChanged extends TabBarState {
  final int index;

  TabBarChanged(this.index);
}
