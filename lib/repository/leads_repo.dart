import 'package:crm_android/models/leads_model.dart';
import 'package:crm_android/services/leads.services.dart';

class LeadsRepo {
  final LeadsServices leadsServices = LeadsServices();

  Future<List<Lead>?> getLeads() async {
    print('Fetching leads from repository');
    return await leadsServices.getLeads();
  }

  Future<bool> updateLeadStatus({required String leadId,required String newStatus}) async {
    print('Updating leadStaus in repo');
    return await leadsServices.updateLeadStatus(leadId, newStatus);
  }
}
