import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/load_image_bloc/load_image_bloc.dart';
import '../blocs/load_image_bloc/load_image_event.dart';
import '../blocs/load_image_bloc/load_image_state.dart';

class LoadImageScreen extends StatefulWidget {
  const LoadImageScreen({super.key});

  @override
  State<LoadImageScreen> createState() => _LoadImageScreenState();
}

class _LoadImageScreenState extends State<LoadImageScreen> {
  String imageUrl = "https://lwfiles.mycourse.app/droidcon-public/f11ed54687792408d5dfc847bf926bae.png";

  @override
  Widget build(BuildContext context) {
    debugPrint("Complete UI Rebuild");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Load image with BLoC"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),

      body: BlocConsumer<LoadUnloadImageBloc, LoadImageState>(
        listener: (context, state) {
          if (state is ImageLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Image successfully loaded"),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case ImageLoadingState():
              return const Center(child: CircularProgressIndicator());

            case ImageLoadedState():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.network(imageUrl, height: 120.0, width: 250.0),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoadUnloadImageBloc>().add(RemoveButtonPressedEvent());
                      },
                      child: const Text("Remove image"),
                    ),
                  ],
                ),
              );

            case ImageNotLoadedState():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No image loaded"),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoadUnloadImageBloc>().add(LoadButtonPressedEvent());
                      },
                      child: const Text("Load Image"),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
