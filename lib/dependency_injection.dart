// lib/providers/bloc_providers.dart

import 'package:crm_android/bloc/auth/auth.bloc.dart';
import 'package:crm_android/bloc/leads/leads.bloc.dart';
import 'package:crm_android/bloc/navigation/navigation.bloc.dart';
import 'package:crm_android/repository/auth_repo.dart';
import 'package:crm_android/repository/leads_repo.dart';
import 'package:crm_android/services/leads.services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LeadBloc>(
          create: (context) => LeadBloc(leadsRepo:LeadsRepo()),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepo: AuthRepo()),
          ),
        // Add more BlocProviders here as needed
      ],
      child: child,
    );
  }
}
