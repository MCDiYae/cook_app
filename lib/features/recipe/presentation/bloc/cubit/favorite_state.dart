part of 'favorite_cubit.dart';


class FavoriteState extends Equatable {
  final List<Recipe> favorites;

  const FavoriteState({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}