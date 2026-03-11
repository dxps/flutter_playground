import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/image_bloc/images_bloc.dart';
import '../blocs/image_bloc/images_event.dart';
import '../blocs/image_bloc/images_state.dart';

class LoadImageScreen extends StatefulWidget {
  const LoadImageScreen({super.key});

  @override
  State<LoadImageScreen> createState() => _LoadImageScreenState();
}

class _LoadImageScreenState extends State<LoadImageScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Widget Rebuilding ...");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Load image with BLoC"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),

      body: BlocConsumer<ImagesBloc, ImagesState>(
        listener: (context, state) {
          if (state is ImageLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.images.length} images successfully loaded."),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          debugPrint("Widget Body Rebuilding ...");
          switch (state) {
            case ImageLoadingState():
              return const Center(child: CircularProgressIndicator());

            case ImageLoadedState():
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: state.images.map((image) {
                          return Card(
                            child: Image.asset(
                              image.url,
                              width: image.size,
                              height: image.size,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.read<ImagesBloc>().add(RemoveButtonPressedEvent());
                          },
                          child: const Text("Unload images"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ImagesBloc>().add(LoadButtonPressedEvent());
                          },
                          child: const Text("Load images"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );

            case ImageNotLoadedState():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No images loaded."),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ImagesBloc>().add(LoadButtonPressedEvent());
                      },
                      child: const Text("Load images"),
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
