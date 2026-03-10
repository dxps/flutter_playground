import 'package:flutter/material.dart';

class LoadImageScreen extends StatefulWidget {
  const LoadImageScreen({super.key});

  @override
  State<LoadImageScreen> createState() => _LoadImageScreenState();
}

class _LoadImageScreenState extends State<LoadImageScreen> {
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    debugPrint("Complete UI Rebuild");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Load image with setState"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageUrl.isEmpty
                ? const Text("No image loaded")
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.network(imageUrl, height: 120.0, width: 250.0),
                  ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                if (imageUrl.isEmpty) {
                  setState(() {
                    imageUrl = "https://lwfiles.mycourse.app/droidcon-public/f11ed54687792408d5dfc847bf926bae.png";
                  });
                } else {
                  setState(() {
                    imageUrl = "";
                  });
                }
              },
              child: imageUrl.isEmpty ? const Text("Load Image") : const Text("Remove Image"),
            ),
          ],
        ),
      ),
    );
  }
}
