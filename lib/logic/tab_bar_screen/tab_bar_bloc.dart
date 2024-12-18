import 'package:flutter_bloc/flutter_bloc.dart';

import 'tab_bar_event.dart';
import 'tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  TabBarBloc() : super(TabBarInitial()) {
    on<TabChanged>(_onTabChanged);
  }

  _onTabChanged(event, emit) {
    emit(TabBarChanged(event.index));
  }
}
