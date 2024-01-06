import 'package:dartz/dartz.dart';
import 'package:pt_platform/data/profile/mapper/profile_mapper.dart';
import 'package:pt_platform/domain/entities/auth_entities/coach_entity.dart';
import 'package:pt_platform/domain/entities/profile_entities/profile_entity.dart';

import '../../../domain/core/entities/failure.dart';
import '../../../domain/core/utils/network/network_info.dart';
import '../../../domain/parameters/profile/change_password_params.dart';
import '../../../domain/parameters/profile/delete_account_params.dart';
import '../../../domain/parameters/profile/edit_image_params.dart';
import '../../../domain/parameters/profile/edit_name_params.dart';
import '../../core/utils/error_handler/error_handler.dart';
import '../profile_data_source/profile_remote_data_source.dart';

abstract class BaseProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();

  Future<Either<Failure, bool>> turnNotification(bool notification);

  Future<Either<Failure, List<CoachEntity>>> getAssignedCoaches();

  Future<Either<Failure, bool>> changePassword(
      ChangePasswordParams changePasswordParams);

  Future<Either<Failure, bool>> editProfileImage(
      EditImageParams editImageParams);

  Future<Either<Failure, bool>> editName(EditNameParams editNameParams);

  Future<Either<Failure, bool>> deleteAccount(
      DeleteAccountParams deleteAccountParams);
}

class ProfileRepositoryImpl extends BaseProfileRepository {
  final BaseProfileRemoteDataSource _profileRemoteDataSource;
  final NetworkInfo _networkInfo;

  ProfileRepositoryImpl(this._profileRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _profileRemoteDataSource.getProfile();

        if (response.status!) {
          return Right(response.data!.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> turnNotification(bool notification) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _profileRemoteDataSource.turnNotification(notification);

        if (response.status!) {
          return const Right(true);
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<CoachEntity>>> getAssignedCoaches() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _profileRemoteDataSource.getAssignedCoaches();

        if (response.status!) {
          return Right(response.data!.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword(
      ChangePasswordParams changePasswordParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _profileRemoteDataSource.changePassword(changePasswordParams);

        if (response.status!) {
          return const Right(true);
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> editProfileImage(
      EditImageParams editImageParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _profileRemoteDataSource.editProfileImage(editImageParams);

        if (response.status!) {
          return const Right(true);
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> editName(EditNameParams editNameParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _profileRemoteDataSource.editName(editNameParams);
        if (response.status!) {
          return const Right(true);
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteAccount(
      DeleteAccountParams deleteAccountParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _profileRemoteDataSource.deleteAccount(deleteAccountParams);
        if (response.status!) {
          return const Right(true);
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
