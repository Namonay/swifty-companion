import 'package:flutter/material.dart';
import 'package:swifty/methods/api.dart';
import 'package:swifty/views/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String login;
  const ProfileScreen({super.key, required this.login});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchProfileData(login),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          if (snapshot.error.toString().contains('401')) { redirect_to_oauth(context); }
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: 64,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "We couldn't find that user.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "They might not exist or are currently hidden.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      icon: const Icon(Icons.home),
                      label: const Text("Bring me back !!!"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );


        }

        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          final Map<String, dynamic> list = snapshot.data ?? {};
          final name = list['usual_full_name'] ?? 'Unknown';
          final imageUrl = list['image']?['versions']?['medium'] ?? '';
          final correctionsPoints = list['correction_point'] ?? 0;
          final level = list['cursus_users']?[1]?['level']?.toDouble() ?? 0.0;
          final location = list['location'] ?? 'Unavailable';
          final skills = list['cursus_users']?[1]?['skills'];
          final unfilteredProjects = list['projects_users'];
          final projects = unfilteredProjects.where((p) => p['status'] != 'creating_group' && p['status'] != 'searching_a_group').toList();

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Profile"),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (imageUrl.isNotEmpty)
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(value: level % 1, minHeight: 8),
                              const SizedBox(height: 4),
                              Text('Level: ${level.toStringAsFixed(2)}'),
                              Text('Correction Points: $correctionsPoints'),
                              Text('Location: $location'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  const TabBar(
                    tabs: [
                      Tab(text: 'Skills'),
                      Tab(text: 'Projects'),
                    ],
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                  ),

                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView.builder(
                          itemCount: skills.length,
                          itemBuilder: (context, index) {
                            final skill = skills[index] as Map<String, dynamic>;
                            final isEven = index % 2 == 0;

                            return Container(
                              color: isEven ? Colors.white70 : Colors.grey[200], // alternate row colors
                              child: ListTile(
                                title: Text(skill['name']),
                                trailing: Text(
                                  skill['level'].toStringAsFixed(2),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            final project = projects[index] as Map<String, dynamic>;
                            final isEven = index % 2 == 0;

                            Text project_grade;
                            if (project['final_mark'] == null) {
                              project_grade = const Text(
                                'pending',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black38,
                                  fontSize: 18,
                                ),
                              );
                            } else {
                              var color = (project['validated?']) ? Colors.green : Colors.red;
                              project_grade = Text(
                                project['final_mark'].toStringAsFixed(2),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                  fontSize: 18,
                                ),
                              );
                            }

                            return Container(
                              color: isEven ? Colors.white70 : Colors.grey[200],
                              child: ListTile(
                                title: Text(project['project']['name']),
                                trailing: project_grade,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text("Unexpected error.")),
        );
      },
    );
  }
}

