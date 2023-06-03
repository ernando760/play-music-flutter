// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:play_music/main.dart';

class AudioItem extends StatefulWidget {
  const AudioItem({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);
  final String imagePath;
  final String title;

  @override
  State<AudioItem> createState() => _MediaItemMusicState();
}

class _MediaItemMusicState extends State<AudioItem> {
  final carouselController = CarouselController();
  double oldvalue = 1000;
  final debouncer = Debouncer(milliseconds: 50);
  late final ValueNotifier<bool> loadingMedia;
  @override
  void initState() {
    super.initState();
    loadingMedia = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    loadingMedia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: 500,
              height: 300,
              child: CarouselSlider.builder(
                  carouselController: carouselController,
                  itemCount: 1,
                  itemBuilder: (context, index, realIndex) {
                    return ValueListenableBuilder(
                      valueListenable: loadingMedia,
                      builder: (context, loading, child) {
                        if (loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: SizedBox(
                            width: 300,
                            height: 300,
                            child: Image.file(
                              alignment: Alignment.center,
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
                              File(widget.imagePath),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  options: CarouselOptions(
                      initialPage: 0,
                      onPageChanged: (index, reason) {
                        loadingMedia.value = true;
                        log("${carouselController.ready}");
                      },
                      onScrolled: (value) async {
                        if (value != null) {
                          debouncer.run(() async {
                            if (value >= oldvalue + .8) {
                              await audioHandler.skipToNext();
                              loadingMedia.value = false;
                              oldvalue = value;
                            } else if (value <= oldvalue - .4) {
                              await audioHandler.skipToPrevious();
                              loadingMedia.value = false;
                              oldvalue = value;
                            }
                          });
                        }
                      },
                      viewportFraction: 2.0)),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 30,
              child: CarouselSlider(
                  carouselController: carouselController,
                  items: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: ValueListenableBuilder(
                        valueListenable: loadingMedia,
                        builder: (context, loading, child) {
                          if (loading) {
                            return const Text('');
                          }
                          return Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: widget.title.length >= 15 ? 20 : 26,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ],
                  disableGesture: true,
                  options: CarouselOptions(
                    initialPage: 0,
                    autoPlay: true,
                    disableCenter: false,
                    viewportFraction: 1.0,
                    autoPlayCurve: Curves.linear,
                    autoPlayAnimationDuration: const Duration(seconds: 5),
                    autoPlayInterval: const Duration(seconds: 7),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
