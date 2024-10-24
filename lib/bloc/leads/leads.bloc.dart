import 'package:crm_android/models/leads_model.dart';
import 'package:crm_android/repository/leads_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'leads.event.dart';
part 'leads.state.dart';

class LeadBloc extends Bloc<LeadEvent, LeadState> {
  final LeadsRepo leadsRepo;
  LeadBloc({required this.leadsRepo}) : super(LeadInitial()) {
    // Load leads
    on<LoadLeads>((event, emit) async {
      emit(LeadLoading());
      await Future.delayed(Duration(seconds: 1));

      try {
        List<Lead>? leads = await leadsRepo.getLeads();

        if (leads != null) {
          emit(LeadLoaded(leads: leads, selectedFilter: 'Pending'));
        } else {
          emit(const LeadError("Failed to load leads."));
        }
      } catch (e) {
        emit(LeadError("An error occurred: $e"));
      }
    });

    // Filter leads
    on<ChangeFilter>((event, emit) async {
      emit(
        LeadLoading(),
      );
      try {
        List<Lead>? leads = await leadsRepo.getLeads();
        if (leads != null) {
          emit(LeadLoaded(leads: leads, selectedFilter: event.filter));
        } else {
          emit(const LeadError("Failed to leads leads..."));
        }
      } catch (e) {
        emit(LeadError("Error occured while fetching Filtered Leads : $e"));
      }
    });

    // Search leads
    on<SearchLeads>((event, emit) {});

    // Update lead status
    on<UpdateLeadStatus>((event, emit) async {
      emit(LeadLoading());
      try {
        final response = await leadsRepo.updateLeadStatus(
            leadId: event.leadId, newStatus: event.newStatus);
        if (response) {
          List<Lead>? leads = await leadsRepo.getLeads();
          if (leads != null) {
            emit(
                LeadLoaded(leads: leads, selectedFilter: event.selectedFilter));
          } else {
            emit(const LeadError('Failed to fetch leads'));
          }
        }
      } catch (e) {
        emit(LeadError("Update Status error occured $e"));
      }
    });
  }
}
