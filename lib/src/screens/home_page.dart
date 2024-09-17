import 'package:app_template/src/bloc/get_tcs_loc/bloc/get_tcs_loc_bloc.dart';
import 'package:app_template/src/models/get_tcs_location_model.dart';
import 'package:app_template/src/screens/location_details_screen.dart';
import 'package:app_template/src/utils/api_client.dart';
import 'package:app_template/src/utils/utils.dart';
import 'package:app_template/src/widgets/common_app_bar.dart';
import 'package:app_template/src/widgets/common_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    // ApiClient apiClient = ApiClient();
    // apiClient.getPvrDetails("0");

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetTcsLocBloc(ApiClient())..add(LoadGetTcsLocEvent("")),
      child: Scaffold(
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight(context, dividedBy: 10)),
          child: CommonAppBar(
            searchTextEditingController: searchController,
          ),
        ),
        body: Column(
          children: [
            Container(
              child: CommonSearchbar(
                searchTextEditingController: searchController,
                onChanged: (value) {},
              ),
            ),
            BlocBuilder<GetTcsLocBloc, GetTcsLocState>(
              builder: (context, state) {
                if (state is GetTcsLocLoadingState) {
                  return Center(child: Container());
                }

                if (state is GetTcsLocErrorState) {
                  return Container();
                }

                if (state is GetTcsLocsLoadedState) {
                  return Expanded(
                    child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount:
                            state.gettcsLocResponseModel.locations.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Text(index.toString()),
                            ),
                            title: Text(state
                                .gettcsLocResponseModel.locations[index].area),
                            subtitle: Text(state.gettcsLocResponseModel
                                .locations[index].location),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              push(
                                context,LocationDetailsScrren(
                                  location: state.gettcsLocResponseModel.locations[index],
                                )
                              );
                            },
                          );
                        }),
                  );
                } else
                  return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
