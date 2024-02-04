import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

dateFormat(date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

urlLauncher(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    launchUrl(Uri.parse(url));
  } else {
    throw "Could not launch $url";
  }
}
