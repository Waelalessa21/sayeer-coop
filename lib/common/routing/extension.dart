import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExtension on BuildContext {
  void pushNamed(String routeName, {Object? arguments}) {
    goNamed(routeName, extra: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    goNamed(routeName, extra: arguments);
  }

  void pushNamedAndRemoveUntil(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    go(routeName);
  }

  void pop() => go('/');
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}
