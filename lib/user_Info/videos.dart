
//Video Contains all the information that a Video is needed to have
class Video{

  Video({
    required this.id,
    required this.title,
    required this.url,
    required this.connectedVideos,
    required this.type,
  });

  final int id;                   // id of Video
  final String title;             // Title of Video
  final String url;               // Youtube url of video (only compatible with youtube)

  List<String> connectedVideos;      // List of Video ID's to Increase or Decrease similar Video's
  String type;
  double recommendValue = 5;      // Recommend rating of this video (the video with the highest recommend rating is next to be recommended to the user)
  bool isWatched = false;         // isWatched is true when the User has already watched the video
  bool isExpanded = false;        // isExpanded is for the "videoListWidget" so it can be expanded in the list

  // increases this Video's recommendValue
  void increase(double val){
    if(isWatched){
      recommendValue = -1;
    } else {
      recommendValue = recommendValue + val;
    }
  }

  // decreases this Video's recommendValue
  void decrease(double val){
    if(!isWatched  && recommendValue > 1){
      recommendValue = recommendValue - val;
    }
  }

  // mark this Video as watched
  void seen(){
    recommendValue = -1;
    isWatched = true;
  }
}
