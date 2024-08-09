import 'package:bloc/bloc.dart';
import 'package:gagclone/bloc/drawer_bloc/drawer_event.dart';
import 'package:gagclone/bloc/drawer_bloc/drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent,DrawerState>{

  DrawerBloc() : super(const DrawerInitial("Home")) {
    on<SelectMenuItem>((event, emit) {
      emit(DrawerMenuSelected(event.menuItem));
    });
    on<ToggleDrawer>((event, emit) {
    });
  }
}