import 'package:dartz/dartz.dart';
import 'package:pt_platform/data/auth/mapper/auth_mapper.dart';
import 'package:pt_platform/domain/entities/auth_entities/auth_entity.dart';

import '../../../app/dependency_injection.dart';
import '../../../app/storage/app_prefs.dart';
import '../../../domain/core/entities/failure.dart';
import '../../../domain/core/utils/network/network_info.dart';
import '../../../domain/entities/auth_entities/category_entity.dart';
import '../../../domain/parameters/auth_parameter/login_params.dart';
import '../../../domain/parameters/auth_parameter/otp_params.dart';
import '../../../domain/parameters/auth_parameter/register_params.dart';
import '../../../domain/parameters/auth_parameter/reset_params.dart';
import '../../core/utils/error_handler/error_handler.dart';
import '../auth_data_source/auth_remote_data_source.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();

  Future<Either<Failure, AuthTraineeEntity>> loginTrainee(
      LoginParams loginParams);

  Future<Either<Failure, AuthCoachEntity>> loginCoach(LoginParams loginParams);

  Future<Either<Failure, String>> sendEmailForget(String email);

  Future<Either<Failure, String>> sendEmailRegister(String email);

  Future<Either<Failure, bool>> sendOtp(OtpParams otpParams);

  Future<Either<Failure, bool>> reSendOtp(String token);

  Future<Either<Failure, bool>> resetPassword(ResetParams resetParams);

  Future<Either<Failure, AuthTraineeEntity>> registerTrainee(
      RegisterTraineeParams registerTraineeParams);

  Future<Either<Failure, AuthCoachEntity>> registerCoach(
      RegisterCoachParams registerCoachParams);

  Future<Either<Failure, bool>> logout(String devicePlayerId);
}

class AuthRepositoryImpl extends BaseAuthRepository {
  final BaseAuthRemoteDataSource _authRemoteDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(this._authRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.getAllCategories();

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
  Future<Either<Failure, AuthTraineeEntity>> loginTrainee(
      LoginParams loginParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.loginTrainee(loginParams);

        if (response.status!) {
          instance<AppPreferences>().setAccessToken(response.data!.token);
          // instance<AppPreferences>().setUserId(response.data!.user!.id);
          instance<AppPreferences>().setUserEntity([
            response.data!.user!.id.toString(),
            response.data!.user!.firstName.toString(),
            response.data!.user!.isSendNotification.toString(),
          ]);
          return Right(response.data!.toDomainTrainee());
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
  Future<Either<Failure, AuthCoachEntity>> loginCoach(
      LoginParams loginParams) async {
    if (await _networkInfo.isConnected) {
      // try {
      final response = await _authRemoteDataSource.loginCoach(loginParams);

      if (response.status!) {
        instance<AppPreferences>().setAccessToken(response.data!.token);
        instance<AppPreferences>().setCoachEntity([
          response.data!.user!.id.toString(),
          response.data!.user!.nickName.toString(),
          response.data!.user!.avatar.toString(),
        ]);
        return Right(response.data!.toDomainCoach());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMessage.DEFAULT));
      }
      // } catch (error) {
      //   return Left(ErrorHandler.handle(error).failure);
      // }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> sendEmailForget(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.sendEmailForget(email);

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
  Future<Either<Failure, String>> sendEmailRegister(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.sendEmailRegister(email);

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
  Future<Either<Failure, bool>> sendOtp(OtpParams otpParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.sendOtp(otpParams);

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
  Future<Either<Failure, bool>> reSendOtp(String token) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.reSendOtp(token);

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
  Future<Either<Failure, bool>> resetPassword(ResetParams resetParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.resetPassword(resetParams);

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
  Future<Either<Failure, AuthTraineeEntity>> registerTrainee(
      RegisterTraineeParams registerTraineeParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _authRemoteDataSource.registerTrainee(registerTraineeParams);
        if (response.status!) {
          instance<AppPreferences>().setAccessToken(response.data!.token);
          instance<AppPreferences>().setUserEntity([
            response.data!.user!.id.toString(),
            response.data!.user!.firstName.toString(),
            response.data!.user!.isSendNotification.toString(),
          ]);
          return Right(response.data!.toDomainTrainee());
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
  Future<Either<Failure, AuthCoachEntity>> registerCoach(
      RegisterCoachParams registerCoachParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _authRemoteDataSource.registerCoach(registerCoachParams);
        if (response.status!) {
          instance<AppPreferences>().setAccessToken(response.data!.token);
          return Right(response.data!.toDomainCoach());
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
  Future<Either<Failure, bool>> logout(String devicePlayerId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _authRemoteDataSource.logout(devicePlayerId);

        if (response.status!) {
          instance<AppPreferences>().removeAccessToken();
          instance<AppPreferences>().removeCoachEntity();
          instance<AppPreferences>().removeFcmToken();
          instance<AppPreferences>().removeUserEntity();
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
