part of 'nav_cubit.dart';

@immutable
class NavState {
  const NavState(this.path);

  final String path;

  factory NavState.fromJson(Map<String, dynamic> json) =>
      NavState(json['path'] as String);
  static Map<String, dynamic>? toJson(NavState state) => {'path': state.path};
}
