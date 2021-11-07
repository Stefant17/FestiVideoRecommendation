import 'package:festi_flutter/user_Info/videos.dart';
import 'package:flutter/material.dart';
import 'package:festi_flutter/user_Info/user.dart';
import 'package:festi_flutter/widget/video_player_widget.dart';

// ignore: must_be_immutable
class RecommendationWidget extends StatefulWidget {
  // instance of the user
  User user;

  // Constructor
  RecommendationWidget({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Recommendation();
}

class _Recommendation extends State<RecommendationWidget>{
  // Variables
   VideoPlayerWidget? vidController;    // instance of the VideoPlayer
   Video? currentVideo;                 // Current Recommended Video

  // recommendedVideo() input: user, output: next Video to be recommended
  Video recommendedVideo(User user){
    // Goes through all user videos and pick the one with the highest "recommendValue" and set as "currentVideo"
    currentVideo = user.videos.reduce((Video a, Video b) => a.recommendValue >= b.recommendValue ? a : b);
    return currentVideo!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // alight at top of screen
      children: <Widget>[
        // button for recommending Video's
        ElevatedButton(onPressed: () => setState(() => {
          // if: no current video, then recommend Video, else: lower the current video's recommendValue and all connected Video's values
          if(currentVideo != null){
            currentVideo!.decrease(1),
            widget.user.reduceVideos(currentVideo!.connectedVideos)
          },

          // recommend new Video
          recommendedVideo(widget.user),

          // if: no current Video  decided, then create new player with the newest recommended video
          if(vidController == null ){
            vidController = VideoPlayerWidget(vid: recommendedVideo(widget.user), user: widget.user)
          },

          // load recommended video
          vidController!.loadNewVideo(currentVideo)}),

          // Text on the Button
          child: currentVideo == null ?  const Text("Recommend Video?") : const Text("Recommend New Video?"),
        ),

        // Display Title of currently playing video (if there is a video in play)
        currentVideo == null ? const Text("") : Text("Psst.. vissir þú " + currentVideo!.title),

        // SizedBox for the VideoController to control the size of the Video
        SizedBox(
          height: 220.0,
          child:  vidController,
        ),
      ],
    );
  }
}