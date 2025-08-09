import 'package:e_commerce/featchers/AUTH/data/repos/auth_repo_impl.dart';
import 'package:e_commerce/featchers/home/presentation/views/CustomBottomNavigationBar.dart';
import 'package:e_commerce/featchers/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required AuthRepoImpl authRepoImpl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: (int value) {},
      ),
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
