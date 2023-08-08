import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../models/drawer_selection_model.dart';

class MyNavigatorObserver extends NavigatorObserver {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    String routeName = _getRouteName(route);
    print('Pushed route: $routeName');
    _updateSelectedItem(route);
    String? currentUserID = _getCurrentUserID();
    if (currentUserID != null && _isProtectedRoute(routeName)) {
      print('User $currentUserID accessed a protected route.');
      // Perform some action, such as logging the incident or redirecting to a login page.
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    String routeName = _getRouteName(route);
    if (previousRoute != null) {
      _updateSelectedItem(previousRoute);
    }
    print('Popped route: $routeName');
  }

  void _updateSelectedItem(Route<dynamic> route) {
    final drawerSelectionState = Provider.of<DrawerSelectionState>(
        route.navigator!.context,
        listen: false);
    final routeName = _getRouteName(route);

    if (drawerSelectionState.selectedItem != routeName) {
      drawerSelectionState.setSelectedItem(routeName);
    }
  }

  String _getRouteName(Route<dynamic> route) {
    return route.settings.name ?? 'Unnamed route';
  }

  String? _getCurrentUserID() {
    User? currentUser = _firebaseAuth.currentUser;
    return currentUser?.uid;
  }

  bool _isProtectedRoute(String routeName) {
    // Check if the route is a protected route, e.g. a route that requires authentication.
    return routeName.startsWith('/protected/');
  }
}
