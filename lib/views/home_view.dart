import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().getUsers();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4facfe), Color(0xff00f2fe)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              return const Center(
                child: Text(
                  'Welcome! Loading users...',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            } else if (state is UsersLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (state is UsersLoaded) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    stretch: true,
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    expandedHeight: 100,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: const Text(
                        "Users List",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff4facfe), Color(0xff00f2fe)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30),
                          ),
                        ),
                      ),
                      stretchModes: const [
                        StretchMode.zoomBackground,
                        StretchMode.fadeTitle,
                        StretchMode.blurBackground,
                      ],
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 10)),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final user = state.users[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    user.name.substring(0, 1).toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      user.email,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'ID: ${user.id}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }, childCount: state.users.length),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              );
            } else if (state is UsersFailure) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
