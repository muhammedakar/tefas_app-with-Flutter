import 'package:gsheets/gsheets.dart';
import 'package:tefas_app/models/gheet_data_model.dart';

class DataGsheets {
  static const String _credantials = r'''

  {
  "type": "service_account",
  "project_id": "tefasapi",
  "private_key_id": "7ccbffd5fb2452cbc0d326478d96792608fefeab",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDOv7irGY2ip10e\nn+ZRz06gzP0YQBr3XpO1oVp+NSHcdLMILD0LKr3YBwOVZaR8tw8JJsYhmTWLA62/\nfsOdO6nkY6Tjkr9qVCtQkBr73L8RvOCBffMuWOtVLvkfeAjC+q0hEXUc0TmBgaBt\n/mJpyY000xdVpaBSkKicY+DO7ndyXOCwCTMWUbab8II0BC2IF5OZHIUZDshEaAoK\nbpzlRwSXT6nFQSizBXzPktPsKSa8TQWqQ7qEtQyQTsL++8MtQ8f/LRdZhcRbvSqd\nW8Kw+GMrjn0FzT5OfG/1oVPbuBa1hOeW6JflehFFEPzvb9k20PW9dLOJqryt60zr\nZBNj1a7BAgMBAAECggEABQOuYWv5vO+tOQBs0CAkio7eNpfbb5N6JqYWsUftndCw\nxOp5wosTVql440c3UZUJBtJLbOYv38LDlIjpCqe3S6RFDAXzoYsQD+Cm3uPwOGhp\n04ov+zhJ4OOGREafg8cbqtknC39hkywHLZPFZEZwp87U2o1tUYNTq5NakPpEqF/g\nI/ZkT0W0ESqcj7KWyuDYcPALeRSR6qHPAz7EFjO5Qol8UZ4jl/5nJhbJnPJA3MiS\nScQlMvCfXHAEx316dqeydGoSNclTebV8lA4Ko+hYeFsB5xUgHLiWvRAoY7HKHLXK\nuXSUQ8cevfaRb7W259PnxARJkbHCj6yT7IaZtS+RdwKBgQDpwcGL9djQhwr2768u\nZ4x187bK6rU9SMkJsFFO1QGkpn77uKt6BtSWk8+BwaWw66L6JagLFqy0pAYWeFUH\n/Biy1OoHFZDGyRWmatODPEq4BpjtQSovzXpuArzEQZ+DbYtrpmSDLyryMvN1dQCF\nM0Rwqo/9TtObB/NH/+4H8iglpwKBgQDibA9mb6EwWY8FDoPJBGqxIO4oKawVyAvu\n3mC7/XU2/X/FoJpRpA7ktGelouzSf1dUqfvsInHyxQFfDmF79KphaFhiL5PUvUKR\nZbqglM/Ac7g848wDqEX66xknV2O9USuVWMBcfG16NzBjmSwmGxf65kWnfv611NBi\nJ7FGqrplVwKBgQCmcNenGH4wvHcKLM/HcuOIeOgGw+gYouLCi1DZmMF6wzJXeb5f\nPM3SCZ0O/xtDRgTdqEJm4tZGKSRMi5HABbhwXTnloW1cnYFU5WuFXkC1l7z78hJf\nxycNfdV6yF8T7cP/+pJG9ibWHYFMeOrN7RsmPcwYyS/Si26mLY0HC12asQKBgQCW\nXdMgYTP3yxI69ne4kJFWTps62unokTCzksVFMz6bpWAsW8sAOuaVJeXLT1bdOCpE\nFJs0J2/rHMAbY46D5mkcRVKk6hnP51yE+L0nFYyer3sEHPgI2cCXsXfD87pOKNC7\n3vPot81wo6QkEL4MFGQpgLFzWdhH4yv8c4W8e3dMAwKBgHLUHf3TOgSQaRE4MPX/\nNYQWILF382IYqtUTj82FbQ2GWxnAMlvMJ3DZIGgKJicVSNVEkhiGsRTXqDg7jWod\nmGFCuMfAuBTdOZzzs3vekjuGK5TDmgdYOxfONl3lYV0PUlOL0NKhTXmrAcD0jS33\nWvSbseQs4tVEuAzEqrnS2dRI\n-----END PRIVATE KEY-----\n",
  "client_email": "tefasapi@tefasapi.iam.gserviceaccount.com",
  "client_id": "117952947821787776272",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/tefasapi%40tefasapi.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
 ''';

  final spreadSheetID = "Your Spread sheet ID";

  final gshhet = GSheets(_credantials);

  Future<List<DataGsheetsData>> getData() async {
    final ss = await gshhet.spreadsheet(spreadSheetID);

    var sheet = ss.worksheetByTitle("Sheet1");
    List data = await sheet!.values.allRows(fromRow: 2);

    List<DataGsheetsData> result = data.map<DataGsheetsData>((e) {
      return DataGsheetsData.fromJson(e);
    }).toList();

    return result;
  }
}
