import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'nav_state.dart';

class NavCubit extends HydratedCubit<NavState> {
  NavCubit() : super(const NavState('/'));

  void setPath(String path) => emit(NavState(path));

  @override
  NavState? fromJson(Map<String, dynamic> json) => NavState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NavState state) => NavState.toJson(state);
}
