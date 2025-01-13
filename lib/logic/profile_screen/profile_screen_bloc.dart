import 'package:bloc/bloc.dart';
import 'package:cure_near/logic/profile_screen/profile_screen_event.dart';
import 'package:cure_near/logic/profile_screen/profile_screen_state.dart';
import 'package:cure_near/services/api_service.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  ProfileScreenBloc() : super(ProfileInitialState()) {
    on<GetProfileDetailsEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final response = await ApiService().get('auth/checkUser', auth: true);

        ///if want to force logout
        // response?.statusCode = 100;
        if (response != null && response.statusCode == 200) {
          emit(ProfileLoadedState(
              name: response.data['user']['fullname'], email: response.data['user']['username'], phone: response.data['user']['phoneNumber']));
        } else {
          emit(ProfileErrorState("Failed to fetch profile details."));
        }
      } catch (e) {
        emit(ProfileErrorState("Failed to fetch profile details."));
      }
    });
  }
}
