class BasePaginationEntity {
  final List<dynamic> data;
  final int total;
  final int? currentPage;
  final int? lastPage;

  BasePaginationEntity({required this.data, required this.total,  this.currentPage=1,  this.lastPage});
}
