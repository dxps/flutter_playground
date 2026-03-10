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
                content: Text("${state.images.length} images successfully loaded."),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case ImageLoadingState():
              return const Center(child: CircularProgressIndicator());

            case ImageLoadedState():
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 30),
                        itemCount: state.images.length,
                        itemBuilder: (context, index) {
                          var image = state.images[index];
                          return Card(
                            child: Image.asset(
                              image.url,
                              width: image.size,
                              height: image.size,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoadUnloadImageBloc>().add(RemoveButtonPressedEvent());
                      },
                      child: const Text("Unload images"),
                    ),
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
                        context.read<LoadUnloadImageBloc>().add(LoadButtonPressedEvent());
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
