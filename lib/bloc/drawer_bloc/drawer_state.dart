import 'package:equatable/equatable.dart';

abstract class DrawerState extends Equatable{

  const DrawerState();

}

class DrawerInitial extends DrawerState{

  final String selectMenuItem;

  const DrawerInitial(this.selectMenuItem);

  @override
  List<Object?> get props => [selectMenuItem];

}

class DrawerMenuSelected extends DrawerState{

  final String selectMenuItem;

  const DrawerMenuSelected(this.selectMenuItem);

  @override
  List<Object?> get props => [selectMenuItem];

}