part of 'nav_cubit.dart';

@immutable
class NavState {
  const NavState(this.location);

  final String location;

  factory NavState.fromJson(Map<String, dynamic> json) =>
      NavState(json['location'] as String);
  static Map<String, dynamic>? toJson(NavState state) =>
      {'location': state.location};
}
