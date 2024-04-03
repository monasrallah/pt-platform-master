import 'package:dartz/dartz.dart';
import 'package:pt_platform/data/coach/mapper/coach_mapper.dart';
import 'package:pt_platform/data/coach_app/mapper/coach_app_mapper.dart';
import 'package:pt_platform/data/home/mapper/home_mapper.dart';

import '../../../domain/core/entities/failure.dart';
import '../../../domain/core/utils/network/network_info.dart';
import '../../../domain/entities/coach_app_entity/calender_entity.dart';
import '../../../domain/entities/coach_app_entity/user_entity.dart';
import '../../../domain/entities/coach_entities/challenge_entity.dart';
import '../../../domain/entities/coach_entities/chat_entity.dart';
import '../../../domain/entities/coach_entities/exercise_logs_entity.dart';
import '../../../domain/entities/coach_entities/section_exercise_entity.dart';
import '../../../domain/entities/coach_entities/video_entity.dart';
import '../../../domain/entities/home_entities/banner_entity.dart';
import '../../../domain/entities/home_entities/faqs_entity.dart';
import '../../../domain/entities/home_entities/food_entity.dart';
import '../../../domain/entities/home_entities/measurements_entity.dart';
import '../../../domain/entities/home_entities/progress_entity.dart';
import '../../../domain/parameters/coach_params/challenge_video_params.dart';
import '../../core/utils/error_handler/error_handler.dart';
import '../coach_app_data_source/coach_app_remote_data_source.dart';

abstract class BaseCoachAppRepository {
  Future<Either<Failure, List<BannerEntity>>> getBanner(int? id);

  Future<Either<Failure, List<UserEntity>>> getUsers({String? search});

  Future<Either<Failure, List<FaqsEntity>>> kyc(String userId);

  Future<Either<Failure, List<ChallengeEntity>>> getChallenges(String coachId);

  Future<Either<Failure, List<ChallengeVideoEntity>>> challengeVideo(
      ChallengeVideoParams challengeVideoParams);

  Future<Either<Failure, List<SectionExercisesEntity>>> getSectionExercise(
      String coachId);

  Future<Either<Failure, List<ExercisesEntity>>> getExercise(
      String coachId, String search);

  Future<Either<Failure, List<VideoEntity>>> getExerciseVideo(
      String coachId, int exerciseId);

  Future<Either<Failure, List<SectionExercisesEntity>>> getSectionWorkOut(
      String coachId);

  Future<Either<Failure, List<ExercisesEntity>>> getWorkOut(
      String coachId, String search);

  Future<Either<Failure, List<VideoEntity>>> getWorkOutVideo(
      String coachId, int exerciseId);

  Future<Either<Failure, List<CalenderCoachEntity>>> getCoachCalendar();

  Future<Either<Failure, List<ChatEntity>>> getVideoChat(String coachId);

  Future<Either<Failure, List<VideoEntity>>> getPersonalTrainingVideo(
      String coachId, int workoutId);

  Future<Either<Failure, List<VideoEntity>>> getExerciseHistory(
      String userId, String coachId);

  Future<Either<Failure, List<ExerciseLogsEntity>>> getExerciseLogs(
      int exerciseLogs, String userId, String coachId);

  Future<Either<Failure, FoodEntity>> getFoodHistory(
      String dateTime, String userId);

  Future<Either<Failure, List<MeasurementsEntity>>> measurements(String userId);

  Future<Either<Failure, List<ProgressEntity>>> progress(String userId);
}

class CoachAppRepositoryImpl extends BaseCoachAppRepository {
  final BaseCoachAppRemoteDataSource _coachAppRemoteDataSource;
  final NetworkInfo _networkInfo;

  CoachAppRepositoryImpl(this._coachAppRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<BannerEntity>>> getBanner(int? id) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource.getBanner(id);

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
  Future<Either<Failure, List<UserEntity>>> getUsers({String? search}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource.getUsers(search);

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
  Future<Either<Failure, List<FaqsEntity>>> kyc(String userId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource.kyc(userId);

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
  Future<Either<Failure, List<ChallengeEntity>>> getChallenges(
      String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource.getChallenges(coachId);

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
  Future<Either<Failure, List<ChallengeVideoEntity>>> challengeVideo(
      ChallengeVideoParams challengeVideoParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource
            .challengeVideo(challengeVideoParams);

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
  Future<Either<Failure, List<ExercisesEntity>>> getExercise(
      String coachId, String search) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachAppRemoteDataSource.getExercise(coachId, search);

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
  Future<Either<Failure, List<VideoEntity>>> getExerciseVideo(
      String coachId, int exerciseId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource.getExerciseVideo(
            coachId, exerciseId);

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
  Future<Either<Failure, List<SectionExercisesEntity>>> getSectionExercise(
      String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachAppRemoteDataSource.getSectionExercise(coachId);

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
  Future<Either<Failure, List<SectionExercisesEntity>>> getSectionWorkOut(
      String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachAppRemoteDataSource.getSectionWorkOut(coachId);

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
  Future<Either<Failure, List<ExercisesEntity>>> getWorkOut(
      String coachId, String search) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachAppRemoteDataSource.getWorkOut(coachId, search);

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
  Future<Either<Failure, List<VideoEntity>>> getWorkOutVideo(
      String coachId, int exerciseId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource.getWorkOutVideo(
            coachId, exerciseId);

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
  Future<Either<Failure, List<CalenderCoachEntity>>> getCoachCalendar() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource.getCoachCalendar();

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
  Future<Either<Failure, List<ChatEntity>>> getVideoChat(String coachId) async {
    if (await _networkInfo.isConnected) {
      final response = await _coachAppRemoteDataSource.getVideoChat(coachId);
      print("test responst else $response");

      if (response.status!) {
        return Right(response.data!.toDomain());
      } else {
        return Left(Failure(ApiInternalStatus.FAILURE,
            response.message ?? ResponseMessage.DEFAULT));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getPersonalTrainingVideo(
      String coachId, int workoutId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource
            .getPersonalTrainingVideo(coachId, workoutId);

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
  Future<Either<Failure, List<ExerciseLogsEntity>>> getExerciseLogs(
      int exerciseLogs, String userId, String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource.getExerciseLogs(
            exerciseLogs, userId, coachId);

        if (response.status!) {
          return Right(response.data!.toDomain());
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        print("kos $error");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getExerciseHistory(
      String userId, String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachAppRemoteDataSource.getExerciseHistory(userId, coachId);

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
  Future<Either<Failure, FoodEntity>> getFoodHistory(
      String dateTime, String userId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachAppRemoteDataSource.getFoodHistory(dateTime, userId);

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
  Future<Either<Failure, List<MeasurementsEntity>>> measurements(
      String userId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource.measurements(userId);

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
  Future<Either<Failure, List<ProgressEntity>>> progress(String userId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachAppRemoteDataSource.progress(userId);

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
}
