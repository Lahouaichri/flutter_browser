import 'dart:async';

import 'package:Castin/features/favorites/domain/usecases/delete_annonces_favorites_usecase.dart';
import 'package:Castin/features/favorites/domain/usecases/get_annonces_favorites_usecase.dart';
import 'package:Castin/shared/services/annonce/domain/entities/annonce_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_browser/history/read_url/domaine/get_url_usecase.dart';
import 'package:injectable/injectable.dart';

part 'annonces_favorites_state.dart';

@injectable
class AnnoncesFavoritesCubit extends Cubit<AnnoncesFavoritesState> {
  final GetUrlUsecase _getUrlUseCase;

  AnnoncesFavoritesCubit(
      this._getAnnoncesFavoritesUseCase, this._deleteAnnoncesFavoritesUseCase)
      : super(const AnnoncesFavoritesLoading());

  String listerAnnoncesFavorites() {
    emit(const AnnoncesFavoritesLoading());
    favoriteSubscription = _getAnnoncesFavoritesUseCase().listen((result) {
      result.fold((error) => emit(const AnnoncesFavoritesError()), (annonces) {
        if (state is AnnoncesFavoritesLoaded) {
          emit((state as AnnoncesFavoritesLoaded).copyWith(annonces: annonces));
        } else {
          emit(AnnoncesFavoritesLoaded(annonces));
        }
      });
    });

    favoriteSubscription?.onError((err) {
      emit(const AnnoncesFavoritesError());
    });
  }

  Future<void> deleteAnnonceFavorite(AnnonceEntity annonceToDel) async {
    try {
      await _deleteAnnoncesFavoritesUseCase();
      List<AnnonceEntity> annonces = (state as AnnoncesFavoritesLoaded)
          .annonces
          .where((annonce) => annonce.id != annonceToDel.id)
          .toList();
      emit((state as AnnoncesFavoritesLoaded).copyWith(annonces: annonces));
    } catch (e) {
      throw Exception("Erreur lors de la suppression de l'annonce des favoris");
    }
  }

  @override
  Future<void> close() {
    favoriteSubscription?.cancel();
    return super.close();
  }
}
