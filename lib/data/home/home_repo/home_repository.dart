import 'package:dartz/dartz.dart';
import 'package:pt_platform/data/home/mapper/home_mapper.dart';
import 'package:pt_platform/data/profile/mapper/profile_mapper.dart';
import 'package:pt_platform/domain/entities/home_entities/banner_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/faqs_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/measurements_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/news_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/progress_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/recipe_entity.dart';

import '../../../domain/core/entities/failure.dart';
import '../../../domain/core/utils/network/network_info.dart';
import '../../../domain/entities/auth_entities/coach_entity.dart';
import '../../../domain/entities/home_entities/food_entity.dart';
import '../../../domain/parameters/home_params/add_food_params.dart';
import '../../../domain/parameters/home_params/answer_questionnaire_params.dart';
import '../../../domain/parameters/home_params/filter_coaches_params.dart';
import '../../../domain/parameters/home_params/get_food_params.dart';
import '../../../domain/parameters/home_params/technical_support_params.dart';
import '../../../domain/parameters/home_params/update_measurements_params.dart';
import '../../../domain/parameters/home_params/update_progress_params.dart';
import '../../../domain/parameters/home_params/update_target_params.dart';
import '../../core/utils/error_handler/error_handler.dart';
import '../home_data_source/home_remote_data_source.dart';

abstract class BaseHomeRepository {
  Future<Either<Failure, List<BannerEntity>>> getBanner(String? id);

  Future<Either<Failure, List<CoachEntity>>> getCoaches(
      FilterCoachesParams filterCoachesParams);

  Future<Either<Failure, bool>> technicalSupport(
      TechnicalSupportParams technicalSupportParams);

  Future<Either<Failure, bool>> feedBack(TechnicalSupportParams feedBackParams);

  Future<Either<Failure, List<NewsEntity>>> news();

  Future<Either<Failure, bool>> newsDetails(String newsId);

  Future<Either<Failure, List<MeasurementsEntity>>> measurements();

  Future<Either<Failure, bool>> updateMeasurements(
      UpdateMeasurementsParams updateMeasurementsParams);

  Future<Either<Failure, List<ProgressEntity>>> progress();

  Future<Either<Failure, bool>> updateProgress(
      UpdateProgressParams updateProgressParams);

  Future<Either<Failure, List<FaqsEntity>>> faqs();

  Future<Either<Failure, List<SurveyEntity>>> questionnaire();

  Future<Either<Failure, bool>> answerQuestionnaire(
      AnswerQuestionnaireParams answerQuestionnaireParams);

  Future<Either<Failure, List<RecipeEntity>>> recipes(String name);

  Future<Either<Failure, List<RecipeEntity>>> supplements(String name);

  Future<Either<Failure, bool>> getTarget();

  Future<Either<Failure, bool>> updateTarget(
      UpdateTargetParams updateTargetParams);

  Future<Either<Failure, FoodEntity>> getFoodHistory(String dateTime);

  Future<Either<Failure, List<AddFoodEntity>>> getFood(
      GetFoodsParams getFoodsParams);

  Future<Either<Failure, bool>> addFood(AddFoodsParams addFoodsParams);

  Future<Either<Failure, bool>> deleteFood(int foodId);
}

class HomeRepositoryImpl extends BaseHomeRepository {
  final BaseHomeRemoteDataSource _homeRemoteDataSource;
  final NetworkInfo _networkInfo;

  HomeRepositoryImpl(this._homeRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, bool>> addFood(AddFoodsParams addFoodsParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.addFood(addFoodsParams);

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
  Future<Either<Failure, bool>> answerQuestionnaire(
      AnswerQuestionnaireParams answerQuestionnaireParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource
            .answerQuestionnaire(answerQuestionnaireParams);

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
  Future<Either<Failure, List<FaqsEntity>>> faqs() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.faqs();

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
  Future<Either<Failure, bool>> feedBack(
      TechnicalSupportParams feedBackParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.feedBack(feedBackParams);

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
  Future<Either<Failure, List<BannerEntity>>> getBanner(String? id) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.getBanner(id);

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
  Future<Either<Failure, List<CoachEntity>>> getCoaches(
      FilterCoachesParams filterCoachesParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _homeRemoteDataSource.getCoaches(filterCoachesParams);

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
  Future<Either<Failure, List<AddFoodEntity>>> getFood(
      GetFoodsParams getFoodsParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.getFood(getFoodsParams);

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
  Future<Either<Failure, FoodEntity>> getFoodHistory(String dateTime) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.getFoodHistory(dateTime);

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
  Future<Either<Failure, bool>> getTarget() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.getTarget();

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
  Future<Either<Failure, List<MeasurementsEntity>>> measurements() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.measurements();

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
  Future<Either<Failure, List<NewsEntity>>> news() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.news();

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
  Future<Either<Failure, bool>> newsDetails(String newsId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.newsDetails(newsId);

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
  Future<Either<Failure, List<ProgressEntity>>> progress() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.progress();

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
  Future<Either<Failure, List<SurveyEntity>>> questionnaire() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.questionnaire();

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
  Future<Either<Failure, List<RecipeEntity>>> recipes(String name) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.recipes(name);

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
  Future<Either<Failure, List<RecipeEntity>>> supplements(String name) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.supplements(name);

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
  Future<Either<Failure, bool>> technicalSupport(
      TechnicalSupportParams technicalSupportParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource
            .technicalSupport(technicalSupportParams);

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
  Future<Either<Failure, bool>> updateMeasurements(
      UpdateMeasurementsParams updateMeasurementsParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource
            .updateMeasurements(updateMeasurementsParams);

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
  Future<Either<Failure, bool>> updateProgress(
      UpdateProgressParams updateProgressParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _homeRemoteDataSource.updateProgress(updateProgressParams);

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
  Future<Either<Failure, bool>> updateTarget(
      UpdateTargetParams updateTargetParams) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _homeRemoteDataSource.updateTarget(updateTargetParams);

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
  Future<Either<Failure, bool>> deleteFood(int foodId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _homeRemoteDataSource.deleteFood(foodId);

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
