import 'package:festi_flutter/user_Info/videos.dart';

// the user has a collection of Video's assigned to him marked "Videos"
class User  {
  // variables
  int id;
  List<Video> videos;

  // constructor
  User({
    required this.id,     // Id for the user
    required this.videos, // list of videos of this specific user
  });

  // reduceVideos() goes through all video Types and reduce every recommend value by 0.5
  void reduceVideos(List<String> videoTypes){
    for (var vid in videos) {
      if(videoTypes.contains(vid.type)){
        vid.decrease(0.5);
      }
    }
  }

  // increaseVideos() goes through all video Types and increase every recommend value by 0.5
  void increaseVideos(List<String> videoTypes){
    for (var vid in videos) {
      if(videoTypes.contains(vid.type))
      {vid.increase(0.5);}
    }
  }
}