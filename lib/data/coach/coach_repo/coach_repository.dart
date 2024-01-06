import 'package:dartz/dartz.dart';
import 'package:pt_platform/data/coach/mapper/coach_mapper.dart';
import 'package:pt_platform/data/home/mapper/home_mapper.dart';
import 'package:pt_platform/domain/entities/coach_entities/chat_entity.dart';

import '../../../domain/core/entities/failure.dart';
import '../../../domain/core/utils/network/network_info.dart';
import '../../../domain/entities/coach_entities/calender_entity.dart';
import '../../../domain/entities/coach_entities/challenge_entity.dart';
import '../../../domain/entities/coach_entities/exercise_logs_entity.dart';
import '../../../domain/entities/coach_entities/personalized_entity.dart';
import '../../../domain/entities/coach_entities/section_exercise_entity.dart';
import '../../../domain/entities/coach_entities/shop_entity.dart';
import '../../../domain/entities/coach_entities/video_entity.dart';
import '../../../domain/entities/home_entities/faqs_entity.dart';
import '../../../domain/entities/home_entities/recipe_entity.dart';
import '../../../domain/parameters/coach_params/add_calender_params.dart';
import '../../../domain/parameters/coach_params/add_video_to_log_params.dart';
import '../../../domain/parameters/coach_params/challenge_video_params.dart';
import '../../../domain/parameters/coach_params/check_promo_code_params.dart';
import '../../../domain/parameters/coach_params/complete_challenge_video_params.dart';
import '../../../domain/parameters/coach_params/date_coach_id_params.dart';
import '../../../domain/parameters/coach_params/packege_payment_params.dart';
import '../../../domain/parameters/coach_params/video_coach_id_params.dart';
import '../../../domain/parameters/home_params/answer_questionnaire_params.dart';
import '../../core/utils/error_handler/error_handler.dart';
import '../coach_data_source/coach_remote_data_source.dart';

abstract class BaseCoachRepository {
  Future<Either<Failure, List<FaqsEntity>>> kyc(String coachId);

  Future<Either<Failure, bool>> saveAnswerKyc(
      AnswerQuestionnaireParams answerQuestionnaireParams);

  Future<Either<Failure, List<VideoEntity>>> getFavorite(String coachId);

  Future<Either<Failure, List<VideoEntity>>> getTodayWorksOut(String coachId);

  Future<Either<Failure, List<ChallengeEntity>>> getChallenges(String coachId);

  Future<Either<Failure, List<ChallengeVideoEntity>>> challengeVideo(
      ChallengeVideoParams challengeVideoParams);

  Future<Either<Failure, bool>> completeChallengeVideo(
      CompleteChallengeVideoParams completeChallengeVideoParams);

  Future<Either<Failure, List<SectionExercisesEntity>>> getSectionExercise(
      String coachId);

  Future<Either<Failure, List<ExercisesEntity>>> getExercise(
      String coachId, String search);

  Future<Either<Failure, List<VideoEntity>>> getExerciseVideo(
      String coachId, int exerciseId);

  Future<Either<Failure, bool>> addFavouriteVideo(
      VideoCoachIdParams videoCoachIdParams);

  Future<Either<Failure, bool>> addTodayWorkOutVideo(
      VideoCoachIdParams videoCoachIdParams);

  Future<Either<Failure, bool>> addToLogVideo(
      AddVideoToLogParams addVideoToLogParams);

  Future<Either<Failure, List<SectionExercisesEntity>>> getSectionWorkOut(
      String coachId);

  Future<Either<Failure, List<ExercisesEntity>>> getWorkOut(
      String coachId, String search);

  Future<Either<Failure, List<VideoEntity>>> getWorkOutVideo(
      String coachId, int exerciseId);

  Future<Either<Failure, List<CalenderEntity>>> getCoachCalendar(
      DateCoachIdParams dateCoachIdParams);

  Future<Either<Failure, bool>> addCoachCalendar(
      AddCalenderParams addCalenderParams);

  Future<Either<Failure, List<ChatEntity>>> getVideoChat(String coachId);

  Future<Either<Failure, bool>> deleteVideoChat(int id);

  Future<Either<Failure, List<ChallengeEntity>>> getAssignedWorkout(
      String coachId);

  Future<Either<Failure, List<RecipeEntity>>> getAssignedMeals(String coachId);

  Future<Either<Failure, List<VideoEntity>>> getPersonalTrainingVideo(
      String coachId, int workoutId);

  Future<Either<Failure, PersonalizedEntity>> getPersonalized(String coachId);

  Future<Either<Failure, ShopEntity>> getShop(String coachId);

  Future<Either<Failure, List<DataEntity>>> getTips(String coachId);

  Future<Either<Failure, StripeEntity>> checkout(
      PackagePaymentParams packagePaymentParams);

  Future<Either<Failure, bool>> checkoutTips(
      TipsPaymentParams packagePaymentParams);

  Future<Either<Failure, DiscountEntity>> checkPromoCode(
      CheckPromoCodeParams checkPromoCodeParams);

  Future<Either<Failure, List<VideoEntity>>> getExerciseHistory(String coachId);

  Future<Either<Failure, List<ExerciseLogsEntity>>> getExerciseLogs(
      int exerciseLogs);
}

class CoachRepositoryImpl extends BaseCoachRepository {
  final BaseCoachRemoteDataSource _coachRemoteDataSource;
  final NetworkInfo _networkInfo;

  CoachRepositoryImpl(this._coachRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<FaqsEntity>>> kyc(String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource.kyc(coachId);

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
  Future<Either<Failure, bool>> saveAnswerKyc(
      AnswerQuestionnaireParams answerQuestionnaireParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource
            .saveAnswerKyc(answerQuestionnaireParams);

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
  Future<Either<Failure, List<ChallengeEntity>>> getChallenges(
      String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource.getChallenges(coachId);

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
        final response =
            await _coachRemoteDataSource.challengeVideo(challengeVideoParams);

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
  Future<Either<Failure, bool>> completeChallengeVideo(
      CompleteChallengeVideoParams completeChallengeVideoParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource
            .completeChallengeVideo(completeChallengeVideoParams);

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
  Future<Either<Failure, List<VideoEntity>>> getFavorite(String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource.getFavorite(coachId);

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
  Future<Either<Failure, List<VideoEntity>>> getTodayWorksOut(
      String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource.getTodayWorksOut(coachId);

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
  Future<Either<Failure, bool>> addFavouriteVideo(
      VideoCoachIdParams videoCoachIdParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.addFavouriteVideo(videoCoachIdParams);

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
  Future<Either<Failure, bool>> addToLogVideo(
      AddVideoToLogParams addVideoToLogParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.addToLogVideo(addVideoToLogParams);

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
  Future<Either<Failure, bool>> addTodayWorkOutVideo(
      VideoCoachIdParams videoCoachIdParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource
            .addTodayWorkOutVideo(videoCoachIdParams);

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
  Future<Either<Failure, List<ExercisesEntity>>> getExercise(
      String coachId, String search) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.getExercise(coachId, search);

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
      // try {
        final response =
            await _coachRemoteDataSource.getExerciseVideo(coachId, exerciseId);

        if (response.status!) {
          return Right(response.data!.toDomain());
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
  Future<Either<Failure, List<SectionExercisesEntity>>> getSectionExercise(
      String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.getSectionExercise(coachId);

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
            await _coachRemoteDataSource.getSectionWorkOut(coachId);

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
            await _coachRemoteDataSource.getWorkOut(coachId, search);

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
        final response =
            await _coachRemoteDataSource.getWorkOutVideo(coachId, exerciseId);

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
  Future<Either<Failure, bool>> addCoachCalendar(
      AddCalenderParams addCalenderParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.addCoachCalendar(addCalenderParams);

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
  Future<Either<Failure, List<CalenderEntity>>> getCoachCalendar(
      DateCoachIdParams dateCoachIdParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.getCoachCalendar(dateCoachIdParams);

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
      try {
        final response = await _coachRemoteDataSource.getVideoChat(coachId);

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
  Future<Either<Failure, bool>> deleteVideoChat(int id) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource.deleteVideoChat(id);

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
  Future<Either<Failure, List<RecipeEntity>>> getAssignedMeals(
      String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource.getAssignedMeals(coachId);

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
  Future<Either<Failure, List<ChallengeEntity>>> getAssignedWorkout(
      String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.getAssignedWorkout(coachId);

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
  Future<Either<Failure, List<VideoEntity>>> getPersonalTrainingVideo(
      String coachId, int workoutId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource.getPersonalTrainingVideo(
            coachId, workoutId);

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
  Future<Either<Failure, PersonalizedEntity>> getPersonalized(
      String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource.getPersonalized(coachId);

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
  Future<Either<Failure, ShopEntity>> getShop(String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource.getShop(coachId);

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
  Future<Either<Failure, List<DataEntity>>> getTips(String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _coachRemoteDataSource.getTips(coachId);

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
  Future<Either<Failure, DiscountEntity>> checkPromoCode(
      CheckPromoCodeParams checkPromoCodeParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.checkPromoCode(checkPromoCodeParams);

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
  Future<Either<Failure, StripeEntity>> checkout(
      PackagePaymentParams packagePaymentParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.checkout(packagePaymentParams);

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
  Future<Either<Failure, bool>> checkoutTips(
      TipsPaymentParams packagePaymentParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.checkoutTips(packagePaymentParams);

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
  Future<Either<Failure, List<ExerciseLogsEntity>>> getExerciseLogs(
      int exerciseLogs) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.getExerciseLogs(exerciseLogs);

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
  Future<Either<Failure, List<VideoEntity>>> getExerciseHistory(
      String coachId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _coachRemoteDataSource.getExerciseHistory(coachId);

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
