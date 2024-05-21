import 'package:flutter/material.dart';
import 'package:google_solution_challenge/screens/home_screens/earthquaker/son_deprem_maps.dart';
import 'package:google_solution_challenge/screens/home_screens/viewmodel/deprem_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SonDeprem extends StatefulWidget {
  const SonDeprem({super.key});

  @override
  State<SonDeprem> createState() => _SonDepremState();
}

class _SonDepremState extends State<SonDeprem>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DepremViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Recent Earthquakes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChangeNotifierProvider.value(
                      value: viewModel,
                      child: SonDepremMaps(
                        viewModel: viewModel,
                      ),
                    );
                  },
                ),
              );
            },
            icon: Icon(Icons.map_outlined),
          ),
        ],
      ),
      body: viewModel.state == ViewState.busy
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : ListView.builder(
              itemCount: viewModel.depremModel?.result?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.grey.shade200,
                        title: Text(
                            viewModel.depremModel?.result?[index].title ?? ""),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            richText(
                              title: "Date: ",
                              subtitle: viewModel
                                      .depremModel?.result?[index].date
                                      ?.toString() ??
                                  "",
                            ),
                            richText(
                              title: "Magnitude: ",
                              subtitle:
                                  "${viewModel.depremModel?.result?[index].mag ?? ""}",
                            ),
                            richText(
                              title: "Depth: ",
                              subtitle:
                                  "${viewModel.depremModel?.result?[index].depth ?? ""} km",
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Location Properties",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            richText(
                              title: "Epi Center: ",
                              subtitle:
                                  "${viewModel.depremModel?.result?[index].locationProperties?.epiCenter?.name ?? ""}",
                            ),
                            richText(
                              title: "Closest City: ",
                              subtitle:
                                  "${viewModel.depremModel?.result?[index].locationProperties?.closestCity?.name ?? ""}",
                            ),
                            SizedBox(height: 20),
                            Text(
                              "AirPorts",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            for (int i = 0;
                                i <
                                    (viewModel
                                            .depremModel
                                            ?.result?[index]
                                            .locationProperties
                                            ?.airports
                                            ?.length ??
                                        0);
                                i++)
                              InkWell(
                                onTap: () {
                                  _openMaps(
                                    viewModel
                                        .depremModel
                                        ?.result?[index]
                                        .locationProperties
                                        ?.airports?[i]
                                        .coordinates
                                        ?.coordinates
                                        ?.last,
                                    viewModel
                                        .depremModel
                                        ?.result?[index]
                                        .locationProperties
                                        ?.airports?[i]
                                        .coordinates
                                        ?.coordinates
                                        ?.first,
                                  );
                                },
                                child: SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${viewModel.depremModel?.result?[index].locationProperties?.airports?[i].name ?? ""}",
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.blueGrey,
                                        size: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              //Show Google Maps with the earthquake location
                              _openMaps(
                                viewModel.depremModel?.result?[index].geojson
                                    ?.coordinates?.last,
                                viewModel.depremModel?.result?[index].geojson
                                    ?.coordinates?.first,
                              );
                              Navigator.pop(context);
                            },
                            child: Text("Show Maps",
                                style: TextStyle(color: Colors.green)),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Close"),
                          ),
                        ],
                      ),
                    );
                  },
                  tileColor: index.isEven ? Colors.blueGrey : Colors.grey[200],
                  title: Text(
                    viewModel.depremModel?.result?[index].title ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: index.isEven
                            ? Colors.white.withOpacity(0.9)
                            : Colors.black),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Date: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index.isEven
                                  ? Colors.white.withOpacity(0.9)
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            viewModel.depremModel?.result?[index].date
                                    ?.toString() ??
                                "",
                            style: TextStyle(
                              color: index.isEven
                                  ? Colors.white.withOpacity(0.9)
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Magnitude: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index.isEven
                                  ? Colors.white.withOpacity(0.9)
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            "${viewModel.depremModel?.result?[index].mag ?? ""}",
                            style: TextStyle(
                                color: index.isEven
                                    ? Colors.white.withOpacity(0.9)
                                    : Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 11,
                    color: index.isEven ? Colors.white : Colors.black,
                  ),
                );
              },
            ),
    );
  }

  Future<void> _openMaps(double? latitude, double? longitude) async {
    String url;

    url = 'https://maps.google.com/?q=$latitude,$longitude';

    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Harita uygulaması açılamadı.';
    }
  }

  RichText richText({required String title, String? subtitle}) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: subtitle ?? "",
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
