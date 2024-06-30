part of 'annonces_favorites_cubit.dart';

abstract class AnnoncesFavoritesState extends Equatable {
  const AnnoncesFavoritesState();
}

class AnnoncesFavoritesLoading extends AnnoncesFavoritesState {
  const AnnoncesFavoritesLoading();

  @override
  List<Object> get props => [];
}

class AnnoncesFavoritesLoaded extends AnnoncesFavoritesState {
  final List<AnnonceEntity> annonces;
  const AnnoncesFavoritesLoaded(this.annonces);

  AnnoncesFavoritesLoaded copyWith({
    List<AnnonceEntity>? annonces,
  }) {
    return AnnoncesFavoritesLoaded(
      annonces ?? this.annonces,
    );
  }

  @override
  List<Object> get props => [annonces];
}

class AnnoncesFavoritesError extends AnnoncesFavoritesState {
  const AnnoncesFavoritesError();

  @override
  List<Object?> get props => [];
}
