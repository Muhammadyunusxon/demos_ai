abstract class AppErrors{
  AppErrors._();

  static const multipleMessage= "You cant send multiple messages at a time";
  static const emptyMessage= "Please type a message";
  static const limit= "Your limit is over";
  static const disableService= "Location services are disabled.";
  static const permissionDenied= "Location permissions are denied";
  static const requestPermission= 'Location permissions are permanently denied, we cannot request permissions.';

}