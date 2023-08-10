import 'package:notification_mindtech_assigment/utils/notification/model/notification_model.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc
{
  BehaviorSubject<NotificationAppDataModel> _notifModelController = BehaviorSubject<NotificationAppDataModel>();

  BehaviorSubject<NotificationAppDataModel> get notifModelController => _notifModelController;
}
final homeBloc=HomeBloc();