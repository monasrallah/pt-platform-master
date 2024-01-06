class PaginationParams {
  int page;

  PaginationParams(this.page);

  Map<String, dynamic> toJson() => {'page': page};
}
