import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revenue_explorer/http/auth.http.dart';
import 'package:revenue_explorer/http/client.http.dart';
import 'package:revenue_explorer/http/http.dart';
import 'package:revenue_explorer/http/user.http.dart';
import 'package:revenue_explorer/main.dart';
import 'package:revenue_explorer/theme.dart';
import 'package:revenue_explorer/widgets/future_handler.dart';

import '../user.state.dart';

class RevExProfilePage extends StatefulWidget {
  const RevExProfilePage({super.key});

  @override
  State<RevExProfilePage> createState() => _RevExProfilePageState();
}

class _RevExProfilePageState extends State<RevExProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<RevExUserState>().loadUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return RevExScaffold(
      title: "Profile",
      body: Center(
        child: Consumer<RevExUserState>(
          builder: (context, state, _) => FutureBuilder(
            future: state.user,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return const Text('Error: Cannot get user data.');
              }

              final user = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _ProfileContent(user: user),
                  ),
                  _ProfileFixedFooter(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  final RevExUser? user;

  const _ProfileContent({required this.user});

  String initializeName(String fullName) {
    final names = fullName.split(' ');
    if (names.length < 2) {
      return fullName;
    }

    final firstNames = names.take(names.length - 1);
    final firstInitials =
        firstNames.map((name) => "${name.substring(0, 1)}.").join(" ");
    final lastName = names.last;
    return "$firstInitials $lastName";
  }

  @override
  Widget build(BuildContext context) {
    final fallbackImage = LayoutBuilder(
      builder: (context, constraints) {
        return Icon(
          Icons.account_circle,
          color: Colors.grey.shade700,
          size: min(
            constraints.maxHeight,
            constraints.maxWidth,
          ),
        );
      },
    );

    return Scrollbar(
      child: SingleChildScrollView(
        primary: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Stack(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            constraints: const BoxConstraints(maxHeight: 200),
                            decoration:
                                const ShapeDecoration(shape: CircleBorder()),
                            child: user?.profilePictureUrl != null
                                ? Image.network(
                                    user!.profilePictureUrl!,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            fallbackImage,
                                    fit: BoxFit.cover,
                                    semanticLabel: 'Profile Photo',
                                  )
                                : fallbackImage,
                          ),
                          Positioned(
                            bottom: 30,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: context.theme.primary.withAlpha(180),
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                user?.fullName != null
                                    ? initializeName(user!.fullName)
                                    : "[Not Found]",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
              if (user != null) ...[
                Text(
                  user!.jobTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                _ProfileUserContact(user: user!),
                _ProfileClientList(user: user!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileUserContact extends StatelessWidget {
  final RevExUser user;
  final List<MapEntry<String, String>> userContactRows;

  _ProfileUserContact({required this.user})
      : userContactRows = [
          MapEntry("Username", user.username),
          MapEntry("Email", user.email),
          MapEntry("Phone", user.phone),
        ];

  @override
  Widget build(BuildContext context) {
    const breakpoint = 450;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: LayoutBuilder(builder: (context, constraints) {
        return Table(
          border: TableBorder.all(
            color: Colors.transparent,
          ),
          columnWidths: {
            0: constraints.maxWidth > breakpoint
                ? const FlexColumnWidth()
                : const IntrinsicColumnWidth(),
            1: const FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: userContactRows
              .map<TableRow>(
                (entry) => TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          "${entry.key}:",
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    TableCell(child: Text(entry.value))
                  ],
                ),
              )
              .toList(),
        );
      }),
    );
  }
}

class _ProfileClientList extends StatefulWidget {
  final RevExUser user;

  const _ProfileClientList({required this.user});

  @override
  State<_ProfileClientList> createState() => _ProfileClientListState();
}

class _ProfileClientListState extends State<_ProfileClientList> {
  late Future<List<RevExClient>> clients;
  final Map<int, bool> expandedStateByClientId = {};

  @override
  void initState() {
    super.initState();
    clients = (() => revExGetClients(widget.user.clientAccountIds))
        .authorize(context);
  }

  @override
  Widget build(BuildContext context) {
    return RevExFutureHandler(
        future: clients,
        errorText: 'Error: Cannot get client data.',
        childBuilder: (_, clients) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                final client = clients[panelIndex];
                setState(() {
                  expandedStateByClientId[client.id] = isExpanded;
                });
              },
              children: [
                ...clients.map(
                  (client) => ExpansionPanel(
                    headerBuilder: (context, isExpanded) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(client.name),
                          Expanded(
                            child: Text(
                              "." * 100,
                              maxLines: 1,
                              style: const TextStyle(
                                letterSpacing: 5,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              client.contactFullName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    isExpanded: expandedStateByClientId[client.id] ?? false,
                    body: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MapEntry(
                            "Contract Size",
                            NumberFormat.simpleCurrency()
                                .format(client.contractSize),
                          ),
                          MapEntry("Contact Email", client.contactEmail),
                          MapEntry("Contact Phone", client.contactPhone),
                        ]
                            .map(
                              (entry) => Text.rich(
                                TextSpan(children: [
                                  TextSpan(text: "${entry.key}: "),
                                  TextSpan(
                                    text: entry.value,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ]),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _ProfileFixedFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withAlpha(50),
            offset: const Offset(0, -3),
          ),
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: FilledButton(
            onPressed: () async {
              context.read<RevExUserState>().unloadUser();
              await revExLogOut();

              if (context.mounted) {
                context.go('/');
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) {
                  if (states.contains(WidgetState.pressed)) {
                    return context.theme.danger;
                  }

                  return context.theme.secondary;
                },
              ),
            ),
            child: const Text("Log Out"),
          ),
        ),
      ),
    );
  }
}
