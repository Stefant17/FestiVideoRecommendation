import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:festi_flutter/user_Info/videos.dart';
import 'package:festi_flutter/user_Info/user.dart';



// ignore: must_be_immutable
class VideoPlayerWidget extends StatelessWidget {
  // Variables
  Video vid;      // Video to be played
  User user;      // User Connected With the Video

  VideoPlayerWidget({
    Key? key,
    required this.vid,
    required this.user
  }) : super(key: key);

  // YouTubePlayerController, controls the video,
  late YoutubePlayerController controller = YoutubePlayerController(
    // initial Video
    initialVideoId: YoutubePlayer.convertUrlToId(vid.url)!, // convert's url from given video to a url that Youtube can use

    // Flags for the Video (options: autoplay, enableCaption, startAt, etc.)
    flags: const YoutubePlayerFlags(
      enableCaption: true,          // Start With caption active
      autoPlay: false,              // "autoPlay: false" = don't automatically play the next video once this one is finished
      controlsVisibleAtStart: true, // should controls be visible at start of video
    )
  );

  // dispose Video
  void dispose(){
    controller.dispose();
  }

  // LoadNewVideo(), input: new Video, output: none
  // loads new video, called when a new video is recommended
  void loadNewVideo(Video? newVideo){
    vid = newVideo!;
    controller.load(YoutubePlayer.convertUrlToId(newVideo.url)!);
  }

  @override
  Widget build(BuildContext context ) => YoutubePlayerBuilder(
    player: YoutubePlayer(  // Youtube Player
      // Youtube Controller, initialized in line:15, controls what video plays and youtube flags
      controller: controller,

      // onEnded: run seen() function in Video Class (marks as seen so it won't be recommended again), and user.increaseVideos() to increase recommend value of connected videos
      onEnded: (data) => {
        vid.seen(),
        user.increaseVideos(vid.connectedVideos)
      },
    ),

    builder: (context, player){
      return SizedBox(
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,  // align the items center to the screen
            children: <Widget>[
              player,
            ],
          ),
        ),
      );
    }
  );
}