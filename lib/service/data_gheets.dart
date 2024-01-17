import 'package:gsheets/gsheets.dart';
import 'package:tefas_app/models/gheet_data_model.dart';

class DataGsheets {
  static const String _credantials = r'''

  {
  "type": "service_account",
  "project_id": "tefasapi",
  "private_key_id": "your private key id",
  "private_key": "-----BEGIN PRIVATE KEY-----\your key\n-----END PRIVATE KEY-----\n",
  "client_email": "tefasapi@tefasapi.iam.gserviceaccount.com",
  "client_id": "117952947821787776272",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/tefasapi%40tefasapi.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
 ''';

  final spreadSheetID = "Your Spreadsheet ID";

  final gshhet = GSheets(_credantials);

  Future<List<DataGsheetsData>> getData() async {
    try {
      final ss = await gshhet.spreadsheet(spreadSheetID);

      var sheet = ss.worksheetByTitle("Sheet1");
      List data = await sheet!.values.allRows(fromRow: 2);

      List<DataGsheetsData> result = data.map<DataGsheetsData>((e) {
        return DataGsheetsData.fromJson(e);
      }).toList();

      return result;
    } catch (e) {
      return [];
    }
  }
}
