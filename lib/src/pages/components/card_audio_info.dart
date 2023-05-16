// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

class CardAudioInfo extends StatelessWidget {
  const CardAudioInfo({
    Key? key,
    required this.image,
    required this.title,
    required this.audioSelected,
    required this.onPressed,
  }) : super(key: key);
  final String image;
  final String title;
  final bool audioSelected;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.file(
                      File(image),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                    color: audioSelected ? Colors.redAccent : null,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
