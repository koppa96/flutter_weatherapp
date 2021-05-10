import 'package:flutter/material.dart';
import 'package:weather_app/state_models.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, this.title = ""}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: "Type the name of the city",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        state.changeSearchText(_controller.text);
                        state
                            .setFuture(Future.delayed(Duration(seconds: 5), () {
                          return <City>[
                            City(1, "Budapest"),
                            City(2, "Veszprém"),
                            City(3, "Székesfehérvár"),
                            City(4, "Győr")
                          ];
                        }));
                      });
                    },
                  )),
            ),
            FutureBuilder(
              future: state.cities,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    var data = snapshot.data as List<City>;
                    if (data.length == 0) {
                      return Expanded(
                        child: Center(
                          child: Text(state.searchText == "" || state.searchText == null
                              ? "Type a city name and tap the search button."
                              : "No results found for \"${state.searchText}\"."),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(data[index].name),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: data.length),
                      );
                    }
                  } else {
                    return Expanded(
                      child: Center(
                        child: Text("An error occurred."),
                      ),
                    );
                  }
                } else {
                  return Expanded(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
