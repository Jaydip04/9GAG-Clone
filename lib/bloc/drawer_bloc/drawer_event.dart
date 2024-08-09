import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DrawerEvent extends Equatable{
  const DrawerEvent();
}

class SelectMenuItem extends DrawerEvent{

  final String menuItem;

  const SelectMenuItem(this.menuItem);

  @override
  List<Object?> get props => throw UnimplementedError();

}

class ToggleDrawer extends DrawerEvent{

  const ToggleDrawer();

  @override
  List<Object?> get props => [];

}