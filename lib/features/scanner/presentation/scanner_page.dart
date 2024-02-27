import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:ticket/core/utils/crypto.dart';
import 'package:ticket/features/scanner/data/model/ticket_item_model.dart';
import 'package:ticket/features/scanner/data/model/ticket_model.dart';
import 'package:ticket/features/scanner/presentation/bloc/scan_bloc.dart';
import 'package:ticket/features/scanner/presentation/widgets/scan_item.dart';
import 'package:toastification/toastification.dart';

import '../../../core/constants/storage_constants.dart';
import '../../../core/services/hive_service.dart';
import '../../../locator.dart';

class ScannerPage extends StatefulWidget {
  ScannerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewState();
}

class _QRViewState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  var hiveService = locator<HiveService>();

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      // controller.dispose();
      // context.read<ScannerCubit>().toggle(scanData.code.toString());
      //EventBusUtils.getInstance().fire(ScannerEvent(scanData.code.toString()));
      // Navigator.pop(context, scanData.code);
      if(result != null && result!.code != null) {
        try {
          controller.pauseCamera();

          var jsonData = jsonDecode(Crypto.decryptAES(result!.code!.toString()));
          var ticket = TicketItemModel.fromJson(jsonData, result!.code!.toString());

          context.read<ScanBloc>().add(ValidScanEvent(ticket: ticket));
        } catch(e) {
          context.read<ScanBloc>().add(InvalidScanEvent(message: 'INVALID JSON'));
        }
      }

    });
  }


  @override
  void initState() {
    super.initState();

    context.read<ScanBloc>().add(ScanInitialEvent());
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var ticketBox = hiveService.getTickets();
    var scanArea = MediaQuery.of(context).size.width-100;

    int count = ticketBox.length;

    return BlocConsumer<ScanBloc, ScanState>(
      listener: (context, state) {
        if(state is ScanCompleteState) {
          count++;
          Future.delayed(const Duration(milliseconds: 1500), () {
            context.read<ScanBloc>().add(ScanInitialEvent());
          });
        }
        else if(state is ScanErrorState) {
          toastification.show(
            context: context,
            title: state.message,
            autoCloseDuration: const Duration(milliseconds: 3000),
          );
          Future.delayed(const Duration(milliseconds: 1500), () {
            context.read<ScanBloc>().add(ScanInitialEvent());
          });
        }
        else if(state is ScanDuplicateState) {
          toastification.show(
            context: context,
            title: state.message,
            autoCloseDuration: const Duration(milliseconds: 3000),
          );
          Future.delayed(const Duration(milliseconds: 1500), () {
            context.read<ScanBloc>().add(ScanInitialEvent());
          });
        }
        else if(state is ScanInitialState) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            controller!.resumeCamera();
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderColor: ((state is ScanErrorState) || (state is ScanDuplicateState)) ? Colors.red :
                    (state is ScanCompleteState) ? Colors.green : Colors.white,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: scanArea),
                onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 50,
                    color: Colors.black45,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: count,
                    itemBuilder: (context, index) {
                      return ScanItem(ticketIndex: index,);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}