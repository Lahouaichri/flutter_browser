import 'package:dartz/dartz.dart';
import 'package:flutter_browser/utils/errors.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUrlUsecase extends UseCaseFuture<Either<Failure, String>, String> {
  final FavoritesRepository favoritesRepository;
  final ConnectedProfilCubit _connectedProfilCubit;

  GetUrlUsecase(this.favoritesRepository, this._connectedProfilCubit);

  @override
  Future<Either<Failure, String>> call({String? params}) {
    if (params == null) {
      return Future.value(const Left(UnexpectedFailure("url vide")));
    }
    ProfilUserEntity me =
        (_connectedProfilCubit.state as ConnectedProfilLoaded).profilUserEntity;
    return favoritesRepository.addFavorite(params.copyWith(userFavId: me.id));
  }
}
