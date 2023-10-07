import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/error_widget.dart';

class ImageSearchApp extends StatefulWidget {
  const ImageSearchApp({super.key});

  @override
  _ImageSearchAppState createState() => _ImageSearchAppState();
}

class _ImageSearchAppState extends State<ImageSearchApp> {
  final String apiKey = '9BDMpfAJ5zxw6iKLyjfcxdRXx0pyLXmfPs-bF5MWDQk';
  final String apiUrl = 'https://api.unsplash.com/search/photos';

  TextEditingController _searchController = TextEditingController();
  List<dynamic> images = [];
  int currentPage = 1;
  int totalPages = 1;
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  Future<void> searchImages(String query, int page) async {
    if (isLoading) return; // Prevent multiple simultaneous requests

    setState(() {
      isLoading = true; // Set loading state
    });

    final response = await http.get(
      Uri.parse(
          '$apiUrl?client_id=$apiKey&query=$query&page=$page&per_page=15'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        if (page == 1) {
          images = data['results'];
        } else {
          images.addAll(data['results']);
        }
        totalPages = data['total_pages'];
        isLoading = false; // Reset loading state
      });
    } else {
      setState(() {
        isLoading = false; // Reset loading state on error
      });
      throw Exception('Failed to load images');
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent &&
        currentPage < totalPages &&
        !isLoading) {
      currentPage++;
      searchImages(_searchController.text, currentPage);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animelia'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Remove focus from the TextField when tapped
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: _searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.pinkAccent,
                          hintText: 'Enter a keyword...',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 199, 216),
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 241, 84, 132),
                              )),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      images.clear();
                      currentPage = 1;
                      searchImages(_searchController.text, currentPage);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final image = images[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 238, 118, 153),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.width * 0.25,
                          imageUrl: image['urls']['thumb'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                              strokeWidth: 3.0,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const ErrorImageWidget(),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  strokeWidth: 4.0,
                ),
              )
          ],
        ),
      ),
    );
  }
}