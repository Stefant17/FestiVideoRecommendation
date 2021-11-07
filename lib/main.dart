import 'package:festi_flutter/user_Info/videos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:festi_flutter/user_Info/user.dart';
import 'package:festi_flutter/widget/recommend_widget.dart';
import 'package:festi_flutter/widget/video_lists.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festi_Verkefni',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Recommendation Assignment'),
    );
  }
  
}

class MyHomePage extends StatefulWidget {
  // Variables
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // initialize user with list of Videos
  // Video(id: id, title: title of the video, url: link to youtube Video, connectedVideos: videoIDs that are related to the video)
  final userInfo = User(videos: [
    Video(id: 1, type: "Animal", title: "Að hægt er að bæta við vörum eftir að pöntun hefur verið lögð inn? ", url : "https://www.youtube.com/watch?v=ymJ0xJeVYJY&list=PLRQGRBgN_EnpkF2ABYHF5zGI7EBA0EgSs&index=2", connectedVideos: ["Cute","Documentary"]),
    Video(id: 2, type: "Cute", title: "Að hægt er að bætta við ákveðna vörulið eftir að pöntun hefur verið lögð inn? ", url : "https://www.youtube.com/watch?v=4GQXoNvRL8w&list=PLRQGRBgN_EnpkF2ABYHF5zGI7EBA0EgSs&index=3&t=312s", connectedVideos: ["Documentary","Animal"]),
    Video(id: 3, type: "Documentary", title: "Að hægt er að skrifa sérstök skilaboð til bílstjóra eftir að pöntun hefur verið lögð inn? ", url : "https://www.youtube.com/watch?v=PMWZuLSVkWY&list=PLRQGRBgN_EnpkF2ABYHF5zGI7EBA0EgSs&index=4", connectedVideos: ["Cute","Animal"]),
    Video(id: 4, type: "Product", title: "Að hægt er að sjá allar allar uppáhalds vörurnar þínar á sérstökum staða frá forsíðu? ", url : "https://www.youtube.com/watch?v=Hwf77PzWDgI&list=PLRQGRBgN_EnpkF2ABYHF5zGI7EBA0EgSs&index=5", connectedVideos: ["Share","Discover"]),
    Video(id: 5, type: "Share", title: "Að hægt er að deila körfu með fjölskyldunni og vinna saman í því að velja vörur í körfu? ", url : "https://www.youtube.com/watch?v=ik0AXnmxZog&list=PLRQGRBgN_EnpkF2ABYHF5zGI7EBA0EgSs&index=6", connectedVideos: ["Product","Discover"]),
    Video(id: 6, type: "Discover", title: "Að hægt er að skoða gómsætar uppskrift og bæta við öllum vörum í körfu? ", url : "https://www.youtube.com/watch?v=lOxC0nYNUMs&list=PLRQGRBgN_EnpkF2ABYHF5zGI7EBA0EgSs&index=7", connectedVideos: ["Share","Product"]),
  ]);

  String page = "recommend"; // index of page

  // buildPage(), returns either the page "Recommend Page" or "VideoList" page
  Widget buildPage(){
    switch (page){
      case "recommend":
        return RecommendationWidget(user: userInfo);
      case "videoList":
        return VideoListWidget(user: userInfo);
      default: 
        return RecommendationWidget(user: userInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // align items at top
            children: <Widget>[
              // button to change Pages
              ElevatedButton(
                // onPressed: change the page view to either "VideoList" or "recommend"
                onPressed: () => setState(() => page == "recommend" ? page = "videoList" : page = "recommend"),
                // title of button ("Recommend Video" when on "videoList" page and "Video List" when on "recommend" page)
                child: page == "recommend" ? const Text("Video List") : const Text("Recommend Video")
              ),
              buildPage(),  // buildPage() line:53
            ],
          ),
        ),
      )
    );
  }
}
