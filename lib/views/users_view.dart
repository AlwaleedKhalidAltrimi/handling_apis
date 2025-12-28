import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../repo/user_repo.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/user_card.dart';
import '../widgets/user_detail_card.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the controller instance
    final controller = Get.find<UserGetXController>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4facfe), Color(0xff00f2fe)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Obx(() {
          if (controller.users.isEmpty && !controller.isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.getUsers();
            });
          }
          if (controller.isLoading && controller.users.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (!controller.hasError && controller.users.isNotEmpty) {
            return CustomScrollView(
              slivers: [
                const CustomUsersAppBar(),

                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final user = controller.users[index];
                    return GestureDetector(
                      onTap: () async {
                        // Load user details first
                        final detailController = Get.put(
                          UserDetailController(Get.find<UserRepo>()),
                        );
                        await detailController.getUserById(user.id.toString());

                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: Dialog(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                padding: const EdgeInsets.all(24),
                                child: Obx(() {
                                  if (detailController.isLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (detailController.hasError) {
                                    return Text(
                                      'Error: ${detailController.errorMessage}',
                                      textAlign: TextAlign.center,
                                    );
                                  }
                                  if (detailController.currentUser != null) {
                                    return UserDetailCard(
                                      user: detailController.currentUser!,
                                    );
                                  }
                                  return const Text(
                                    "User data not available",
                                    textAlign: TextAlign.center,
                                  );
                                }),
                              ),
                            ),
                          ),
                        );
                      },
                      child: UserCard(user: user),
                    );
                  }, childCount: controller.users.length),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            );
          } else if (controller.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${controller.errorMessage}',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      controller.getUsers();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
