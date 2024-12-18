abstract class TabBarEvent {}

class TabChanged extends TabBarEvent {
  final int index;

  TabChanged(this.index);
}
