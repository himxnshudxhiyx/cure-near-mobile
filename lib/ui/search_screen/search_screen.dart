import 'package:cure_near/logic/search_bar/search_bar_event.dart';
import 'package:cure_near/services/logger_service.dart';
import 'package:cure_near/widgets/custom_app_bar.dart';
import 'package:cure_near/widgets/custom_inkwell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../logic/search_bar/search_bar_bloc.dart';
import '../../logic/search_bar/search_bar_state.dart';
import '../../widgets/text_feild.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchTextController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    _searchFocusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Search',
        leadingIcon: CustomInkwell(
          onTap: () {
            GoRouter.of(context).pop('true');
          },
          child: Icon(
            CupertinoIcons.back,
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) {
          return SearchBloc();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Column(
            children: [
              BlocConsumer<SearchBloc, SearchBarState>(
                listener: (context, state) {},
                builder: (context, state) => AppTextField(
                  controller: _searchTextController,
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  focusNode: _searchFocusNode,
                  borderColor: Colors.transparent,
                  hintText: "Search Doctor, Hospital, Medicine",
                  hintFontSize: 12,
                  prefixIcon: Icon(CupertinoIcons.search),
                  onChanged: (val) {
                    if (val != '') {
                      context.read<SearchBloc>().add(SearchStarted());
                    }
                  },
                ),
              ),
              Expanded(
                child: BlocConsumer<SearchBloc, SearchBarState>(
                  listener: (context, state) {
                    Logger.logObject(object: 'State in Listener: $state');
                    if (state is SearchBarError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    Logger.logObject(object: 'State in Builder: $state');
                    if (state is SearchBarStarted) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (state is SearchBarFinished) {
                      return const Center(
                        child: Text("Search completed! Display results here."),
                      );
                    } else if (state is SearchBarError) {
                      return Center(
                        child: Text(
                          "An error occurred: ${state.message}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const Center(
                      child: Text("Start searching by typing above."),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
