import '../../../app/enum.dart';
import '../../../domain/core/entities/base_pagenation_entity.dart';
import '../models/pagenation_data/pagenation_model.dart';

extension PagenationDataModelMapper on Pagination {
  BasePaginationEntity toDomain() {
    List<dynamic> allData =
        getEntityList(paginationType ?? PaginationTypes.notifications, data);
    return BasePaginationEntity(
      data: allData,
      total: total,
    );
  }
}

List<dynamic> getEntityList(
    PaginationTypes paginationType, List<dynamic> data) {
  List<dynamic> allData = [];
  switch (paginationType) {
    case PaginationTypes.notifications:

    default:
      return allData;
  }
}
