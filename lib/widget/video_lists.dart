import 'package:festi_flutter/user_Info/videos.dart';
import 'package:flutter/material.dart';
import 'package:festi_flutter/widget/video_player_widget.dart';
import 'package:festi_flutter/user_Info/user.dart';


// ignore: must_be_immutable
class VideoListWidget extends StatefulWidget{

  // Variables
  User user;  // current User

  // Constructor
  VideoListWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState()  => _VideoListWidget();
}

class _VideoListWidget extends State<VideoListWidget> {

  bool isVisible = false;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Container(
      child: buildPanel(),
    ),
  );


  // buildPanel builds the list of video's
  Widget buildPanel(){
    return SingleChildScrollView(    // make the list scrollable
      child: ExpansionPanelList(   // the List it self

        // Callback used for when an item in the list is expanded. input: index of item, whether or not it's expanded
        expansionCallback: (int index, bool isExpanded){
          setState(() {
            widget.user.videos[index].isExpanded = !isExpanded;   // set Video variable "isExpanded" to either true or false depending on whether or not it is expanded
            isVisible = !isVisible;
          });
        },

        // goes through all the video's connected by the user and creates element "expansion panel" for each one
        children: widget.user.videos.map<ExpansionPanel>((Video item ) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              // ListTile is the Title of the list which can be clicked to be expanded
              return ListTile(
                title: Text(item.title),      // title of the list
                subtitle: item.isWatched?     // whether or not the Video has already been watched
                const Text("Watched")         // if the video has been watched then display "watched" else display nothing
                    : const Text("")
              );
            },

            // SizeBox of the Video, show's everything that will be seen if the list is expanded
            body: SizedBox(
              height: 250,
              child: isVisible? VideoPlayerWidget(vid : item, user: widget.user,) : Text("no"),
            ),

            isExpanded: item.isExpanded
          );
        }).toList(),
      ),
    );
  }
}

class ListItem{
  Video video;
  bool isVisible;
  bool isExpanded;
  ListItem({
    required this.video,
    required this.isVisible,
    required this.isExpanded,
  });
}


