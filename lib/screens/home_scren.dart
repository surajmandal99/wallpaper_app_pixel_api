import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app_pixel_api/screens/full_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List images = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    fectchapi();
    loadMore();
  }

  fectchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {'Authorization': 'Your_Key'}).then((value) {
      Map result = jsonDecode(value.body);
      print(result);
      setState(() {
        images = result['photos'];
      });
      print(images[0]);
    });
  }

  loadMore() async {
    setState(() {
      page++;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&&page=$page';
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          'Pjby5WcdXXZnhsMbMZybm2WMyVyvVKVtkDivr21SWllsYgoodPxHHrPL'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.amber,
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreen(
                                  imageUrl: images[index]['src']['large2x'])));
                    },
                    child: Container(
                      color: Colors.yellow,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          )),
          InkWell(
            onTap: () {
              loadMore();
            },
            child: Container(
              color: Colors.black,
              height: 58,
              width: double.infinity,
              child: const Center(
                child: Text(
                  "Load More ",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}





//Api key=>  Pjby5WcdXXZnhsMbMZybm2WMyVyvVKVtkDivr21SWllsYgoodPxHHrPL