import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/images_cubit.dart';
import '../states/images_state.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Widget Rebuilding ...");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Load images with Cubit"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorLight,
      ),

      body: BlocConsumer<ImagesCubit, ImagesState>(
        listener: (context, state) {
          if (state is ImagesLoadedState) {
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
            case ImagesLoadingState():
              return const Center(child: CircularProgressIndicator());

            case ImagesLoadedState():
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                              context.read<ImagesCubit>().unloadImages();
                            },
                            child: const Text("Unload images"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ImagesCubit>().loadImages();
                            },
                            child: const Text("Load images"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );

            case ImagesNotLoadedState():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Text("No images loaded."),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ImagesCubit>().loadImages();
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
