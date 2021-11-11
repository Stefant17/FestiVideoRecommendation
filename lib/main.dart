import 'package:festi_flutter/user_Info/videos.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:festi_flutter/user_Info/user.dart';
import 'package:festi_flutter/widget/recommend_widget.dart';
import 'package:festi_flutter/widget/video_lists.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:festi_flutter/dataBaseFunctions/retrieving_file.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //initialize firebase Storeage
  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Festi_Verkefni',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: storage.listFiles(),
        builder: (context, AsyncSnapshot<ListResult> snapshot) {
          if(snapshot.hasError){
            print("something went wrong");
            return Text("wrong");
          }else if(snapshot.hasData){
            return Container(
              child: ListView.builder(
                  itemCount: snapshot.data!.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("got data");
                    return Text(snapshot.data!.items[index].name);
                  }
            ));
            //return MyHomePage(title: 'Recommendation Assignment');
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
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
  // Video(id: id, title: title of the video, url: link to youtube Video, connectedVideos: Names of Types that are related to the video)
  final userInfo = User(
    id: 1,
    videos: [
      Video(id: 1, type: "Animal", title: "Að hægt er að bæta við vörum eftir að pöntun hefur verið lögð inn? ", url : "https://www.youtube.com/watch?v=ymJ0xJeVYJY&list=PLRQGRBgN_EnpkF2ABYHF5zGI7EBA0EgSs&index=2", connectedVideos: ["Cute","Documentary"]),
      Video(id: 2, type: "Cute", title: "Að hægt er að bætta við ákveðna vörulið eftir að pöntun hefur verið lögð inn? ", url : "https://www.youtube.com/watch?v=4GQXoNvRL8w&list=PLRQGRBgN_EnpkF2ABYHF5zGI7EBA0EgSs&index=3&t=312s", connectedVideos: ["Documentary","Animal"]),
      Video(id: 3, type: "Documentary", title: "Að hægt er að skrifa sérstök skilaboð til bílstjóra eftir að pöntun hefur verið lögð inn? ", url : "https://www.youtube.com/watch?v=PMWZuLSVkWY&list=PLRQGRBgN_EnpkF2ABYHF5zGI7EBA0EgSs&index=4", connectedVideos: ["Cute","Animal"]),

      Video(id: 4, type: "Podcast", title: "Að hægt er að sjá allar allar uppáhalds vörurnar þínar á sérstökum staða frá forsíðu? ", url : "https://www.youtube.com/watch?v=ZzMwDSh6HM0", connectedVideos: ["Audio","Show"]),
      Video(id: 5, type: "Audio", title: "Að hægt er að deila körfu með fjölskyldunni og vinna saman í því að velja vörur í körfu? ", url : "https://www.youtube.com/watch?v=9rYXr8v3P9Y", connectedVideos: ["Podcast","Show"]),
      Video(id: 6, type: "Show", title: "Að hægt er að sjá hvaða vörum við mælum með að vanti í körfuna þína í körfu skjá? ", url : "https://www.youtube.com/watch?v=4axEMjPda8Q", connectedVideos: ["Audio","Podcast"]),

      Video(id: 8, type: "Number", title: "Að hægt er að sjá allar kvittanir í dagatali á profile skjá? ", url : "https://www.youtube.com/watch?v=n8COZPpQWgQ", connectedVideos: ["Learning"]),
      Video(id: 9, type: "Learning", title: "Að hægt er að sjá stöðu pöntunar eftir að hún hefur verið lögð inn úr valmynd af forsíðu, nákvæmari áætlun á komu til þín meðal annars ? ", url : "https://www.youtube.com/watch?v=rSoYRFYT3fA", connectedVideos: ["Number"]),

      Video(id: 10, type: "Computer", title: "Að hægt er að sjá vörur sem við mælum með ef þú kaupir ákveðna væri í vöruspjaldi vöru? ", url : "https://www.youtube.com/watch?v=vYLcQAyDkUQ", connectedVideos: ["Tech"]),
      Video(id: 11, type: "Tech", title: "Að hægt er að hafna útskiptum að ákveðnum vörum með því að draga þær til vinstri í körfunni, við munum síðan að þú viljir ekki skipta út þessari værum og pössum okkur að merka það næst þegar þú setur hana í körfu ? ", url : "https://www.youtube.com/watch?v=2jrpDICci-k", connectedVideos: ["Computer"]),
    ],
  );

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
