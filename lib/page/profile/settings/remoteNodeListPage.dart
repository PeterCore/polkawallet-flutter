import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polka_wallet/common/consts/settings.dart';
import 'package:polka_wallet/service/substrateApi/api.dart';
import 'package:polka_wallet/store/settings.dart';
import 'package:polka_wallet/utils/i18n/index.dart';

const default_node_zh = {
  'info': 'kusama',
  'ss58': 2,
  'text': 'Kusama (Polkadot Canary, hosted by Polkawallet)',
  'value': 'ws://mandala-01.acala.network:9954/',
};
const default_node = {
  'info': 'kusama',
  'ss58': 2,
  'text': 'Kusama (Polkadot Canary, hosted by Parity)',
  'value': 'wss://kusama-rpc.polkadot.io/',
};

// TODO: display ping speed
class RemoteNodeListPage extends StatelessWidget {
  RemoteNodeListPage(this.store);

  static final String route = '/profile/endpoint';
  final Api api = webApi;
  final SettingsStore store;

  @override
  Widget build(BuildContext context) {
    var dic = I18n.of(context).profile;
    List<EndpointData> endpoints = List<EndpointData>.of(networkEndpoints);
    endpoints.retainWhere((i) => i.info == store.endpoint.info);
    List<Widget> list = endpoints
        .map((i) => ListTile(
              leading: Container(
                width: 36,
                child: Image.asset('assets/images/public/${i.info}.png'),
              ),
              title: Text(i.info),
              subtitle: Text(i.text),
              trailing: Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                if (store.endpoint.value == i.value) {
                  Navigator.of(context).pop();
                  return;
                }
                store.setEndpoint(i);
                store.setNetworkLoading(true);
                webApi.launchWebview();
                Navigator.of(context).pop();
              },
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(dic['setting.node.list']),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(padding: EdgeInsets.only(top: 8), children: list),
      ),
    );
  }
}
