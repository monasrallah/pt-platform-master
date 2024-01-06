class PersonalizedEntity {
  List<DataEntity> video;
  List<DataEntity> image;
  List<DataEntity> pdf;
  List<DataEntity> freeText;

  PersonalizedEntity({
    required this.video,
    required this.image,
    required this.pdf,
    required this.freeText,
  });
}

class DataEntity {
  int id;
  String value;

  DataEntity({
    required this.id,
    required this.value,
  });

}
