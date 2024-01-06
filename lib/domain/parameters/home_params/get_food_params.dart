class GetFoodsParams {
  String search;
  int skip;

  GetFoodsParams({
    required this.search,
    required this.skip,
  });

  Map<String, dynamic> toJson() => {
        "name": search,
        "skip": skip,
      };
}
