# blocify

A project that uses the flutter_bloc package to manage the state.

<br/>

## About

Using BLoC:

- The state can be any of the three subclasses of `LoadImageState`.
- The events that are emitted are `LoadButtonPressedEvent` and `RemoveButtonPressedEvent`, both as subclasses of `LoadUnloadImageEvent`.

The flow of the state change is like this:

- Initially, as no image is loaded, the user clicks _Load Image_ button.
- The button handler notifies the BLoC of the `LoadButtonPressedEvent`.
- The BLoC - implemented in `LoadUnloadImageBloc` - handles the event:
    - First, it changes the state to `ImageLoadingState` by emitting it.
    - Next, it gets the `imageUrl` from the event, and changes the state to `ImageLoadedState` by emitting it.
    - Finally, it changes the state to `ImageLoadedState` (with the received `imageUrl`) by emitting it.

```
      ┌────────────┐
      │   Button   │
      └────────────┘
             │
             │
             │notifies the BLoC with
             │
             │
             ▼
╔════════════════════════╗
║ LoadButtonPressedEvent ║
╚════════════════════════╝
             │
             │
             │   ╔════════════╗
             └──▶║    BLoC    ║
                 ╚════════════╝
                        │
                        │1. emits                  ┌───────────────────┐    reflected in    ┏━━━━━━━━━━━━━━━━━┓
                        ├─────────────────────────▶│ ImageLoadingState ├───────────────────▶┃ LoadImageScreen ┃
                        │                          └───────────────────┘                    ┗━━━━━━━━━━━━━━━━━┛
                        │
                        │2. processes the event    ┌──────────────────────────┐
                        ├─────────────────────────▶│ gets imageUrl from event │
                        │                          └──────────────────────────┘
                        │
                        │3. emits                  ┌──────────────────┐     reflected in    ┏━━━━━━━━━━━━━━━━━┓
                        └─────────────────────────▶│ ImageLoadedState │────────────────────▶┃ LoadImageScreen ┃
                                                   └──────────────────┘                     ┗━━━━━━━━━━━━━━━━━┛
```

<br/>

## Usage

Run the project, for example, using the Web version of it with the command `flutter run -d chrome`.

```

```
