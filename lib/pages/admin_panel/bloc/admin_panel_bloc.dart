import 'package:bloc/bloc.dart';
import 'admin_panel_event.dart';
import 'admin_panel_state.dart';

class AdminPanelBloc extends Bloc<AdminPanelEvent, AdminPanelState> {
  AdminPanelBloc() : super(AdminPanelInitial());

  Stream<AdminPanelState> mapEventToState(AdminPanelEvent event) async* {
    // Handle events and manage state transitions
  }
}
