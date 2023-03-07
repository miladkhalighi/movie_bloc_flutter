// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bottom_navigation_cubit.dart';

class BottomNavigationState {
  final int currentIndex;
  BottomNavigationState({
    required this.currentIndex,
  });

  factory BottomNavigationState.initial() =>
      BottomNavigationState(currentIndex: 0);

  @override
  bool operator ==(covariant BottomNavigationState other) {
    if (identical(this, other)) return true;

    return other.currentIndex == currentIndex;
  }

  @override
  int get hashCode => currentIndex.hashCode;

  BottomNavigationState copyWith({
    int? currentIndex,
  }) {
    return BottomNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  String toString() => 'BottomNavigationState(currentIndex: $currentIndex)';
}
