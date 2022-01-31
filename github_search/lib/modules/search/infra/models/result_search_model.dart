import 'package:github_search/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  ResultSearchModel({
    required String title,
    required String content,
    required String img,
  }) : super(
          title: title,
          img: img,
          content: content,
        );

  factory ResultSearchModel.fromJson(Map<String, dynamic> json) =>
      ResultSearchModel(
        title: json['title'],
        img: json['img'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'img': img,
        'content': content,
      };
}
