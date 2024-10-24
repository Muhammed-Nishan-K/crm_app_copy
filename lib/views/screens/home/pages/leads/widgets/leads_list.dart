import 'package:crm_android/bloc/leads/leads.bloc.dart';
import 'package:crm_android/controller/screen_size_controller.dart';
import 'package:crm_android/models/leads_model.dart';
import 'package:crm_android/utils/colors.dart';
import 'package:crm_android/views/screens/home/pages/leads/widgets/build_leads_list.dart';
import 'package:crm_android/views/screens/home/pages/leads/widgets/leads_card_skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

const List<String> leadStatuses = [
  'Closed',
  'Not Responded',
  'Rejected',
  'Pending',
  'On College',
  'Need to Follow Up',
];

Widget buildLeadsList(LeadBloc leadBloc) {
  return BlocBuilder<LeadBloc, LeadState>(
    bloc: leadBloc,
    builder: (context, state) {
      if (state is LeadError) {
        return Center(child: Text('Error: ${state.error}'));
      } else if (state is LeadLoading) {
        return buildLoadingLeadsList();
      } else if (state is LeadLoaded) {
        return buildLoadedLeadsList(state.leads, leadBloc,state.selectedFilter!);
      }
      return Center(child: CircularProgressIndicator());
    },
  );
}
