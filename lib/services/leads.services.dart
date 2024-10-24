import 'dart:convert';
import 'package:crm_android/models/leads_model.dart';
import 'package:http/http.dart' as http;

class LeadsServices {
  Future<List<Lead>?> getLeads() async {
    try {
      final uri = Uri.parse("http://157.173.219.135:3001/api/getLeads");
      final response = await http.post(uri, body: {"id": "#CNC0010"});
      if (response.statusCode == 200) {
        final leadsJson = jsonDecode(response.body)['data'] as List<dynamic>;
        final List<Lead> leads =
            leadsJson.map((lead) => Lead.fromJson(lead)).toList();
        return leads;
      } else {
        print('Failed to load leads. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching leads: $e');
      return null;
    }
  }



  Future<bool> updateLeadStatus(String leadId, String newStatus) async {
    try {
      final uri = Uri.parse("http://157.173.219.135:3001/api/updateLeadStatus");
      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': leadId,
          'newStatus': newStatus,
        }),
      );

      if (response.statusCode == 200) {
        // The server successfully updated the lead status
        return true;
      } else {
        // The server returned an error
        print('Failed to update lead status. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error occurred while updating lead status: $e');
      return false;
    }
  }
}
