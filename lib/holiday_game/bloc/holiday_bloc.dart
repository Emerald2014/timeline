import 'package:bloc/bloc.dart';
import 'package:timeline/dual_game_classic/bloc/game_bloc.dart';
import '../repository/holiday_repository.dart';
import '../model/holiday_game_card.dart';
part 'holiday_event.dart';
part 'holiday_state.dart';



class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {
  HolidayBloc(this.holidayRepository): super(HolidayState());
  final HolidayRepository holidayRepository;
  }
