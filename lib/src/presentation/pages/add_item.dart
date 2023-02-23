import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:order_mgmt_flutter/src/cubit/cubit.dart';
import 'package:order_mgmt_flutter/src/service/service.dart';
import 'package:order_mgmt_flutter/src/presentation/presentation.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => AddItemState();
}

final itemNameController = TextEditingController();
final itemCodeController = TextEditingController();
final weightController = TextEditingController();
final sizeController = TextEditingController();
final quantityController = TextEditingController();
final meltController = TextEditingController();
final stampController = TextEditingController();
final hookController = TextEditingController();
final designController = TextEditingController();
final sizeSmplController = TextEditingController();
final refNoController = TextEditingController();
final remarkController = TextEditingController();
final daysController = TextEditingController();
final dueDateController = TextEditingController();
final cnt = SingleValueDropDownController();

class AddItemState extends State<AddItem> with SingleTickerProviderStateMixin {
  TransformationController? imgCtrl;
  TapDownDetails? tapDowDetails;

//zoom with animation
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  static List<XFile>? _image = [];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<XFile?> getImage(bool isCamera) async {
    XFile? img;
    if (isCamera) {
      img =
          (await ImagePicker().pickImage(source: ImageSource.camera)) as XFile?;
    } else {
      img = (await ImagePicker().pickImage(source: ImageSource.gallery))
          as XFile?;
    }
    setState(() {
      AddItemState._image?.add(img!);
      Image.file(
        File(AddItemState._image![0].path),
      );
    });
  }

  Widget appBarTitle = const Text("Add Item");

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final val = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Alert"),
                content: const Text('Do you want to exit?'),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('Yes')),
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No')),
                ],
              );
            });
        if (val != null) {
          return Future.value(val);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffffbf1de),
        appBar: AppBar(
          title: Center(child: appBarTitle),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xfffd4af37),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      BlocProvider(
                        create: (context) => ItemNameCubit(AddItemService()),
                        child: DropDownBuilder(
                          cnt: cnt,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: FormAddItemTextField(
                                inputController: weightController,
                                label: 'Weight',
                                mxLine: 1,
                                textType: TextInputType.number,
                              )),
                          const SizedBox(width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: FormAddItemTextField(
                                inputController: sizeController,
                                label: 'Size',
                                mxLine: 1,
                                textType: TextInputType.text,
                              )),
                          const SizedBox(width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: FormAddItemTextField(
                                inputController: quantityController,
                                label: 'Quantity',
                                textType: TextInputType.number,
                                mxLine: 1,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: FormAddItemTextField.withChangeEvent(
                                inputController: meltController,
                                label: 'Melt %',
                                textType: TextInputType.number,
                                onChangeEvent: getStamp,
                                mxLine: 1,
                              )),
                          const SizedBox(width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: FormAddItemTextField(
                                inputController: stampController,
                                label: 'Stamp',
                                textType: TextInputType.text,
                                mxLine: 1,
                              )),
                          const SizedBox(width: 25),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: FormAddItemTextField(
                                inputController: hookController,
                                label: 'Hook',
                                textType: TextInputType.text,
                                mxLine: 1,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: FormAddItemTextField(
                              inputController: designController,
                              label: 'Design Sample',
                              mxLine: 1,
                              textType: TextInputType.text,
                            )),
                        const SizedBox(width: 20),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: FormAddItemTextField(
                              inputController: sizeSmplController,
                              label: 'Size Sample',
                              mxLine: 1,
                              textType: TextInputType.text,
                            )),
                      ]),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: FormAddItemTextField(
                                  inputController: refNoController,
                                  label: 'Customer Refno',
                                  textType: TextInputType.text,
                                  mxLine: 1,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: FormAddItemTextField.withChangeEvent(
                                inputController: daysController,
                                label: 'Days',
                                onChangeEvent: getDueDate,
                                textType: TextInputType.number,
                                mxLine: 1,
                              )),
                          const SizedBox(width: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: FormAddItemTextField.unEditable(
                                inputController: dueDateController,
                                label: 'Due Date',
                                mxLine: 1,
                                boolval: false,
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: FormAddItemTextField(
                            inputController: remarkController,
                            label: 'Remark',
                            mxLine: 5,
                            textType: TextInputType.text,
                          )),
                      const SizedBox(height: 10),
                      Row(children: [
                        Column(children: [
                          Text(
                            "Take Design Sample :",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Palette.text,
                            ),
                          ),
                        ]),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 5,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _image!.length < 2
                                          ? getImage(true)
                                          : null;
                                    },
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Palette.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      shadowColor: Palette.gold,
                                      elevation: 5,
                                      padding: EdgeInsets.all(10),
                                      backgroundColor:
                                          Palette.text, // <-- Splash color
                                    ))),
                            Text(
                              "Camera",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Palette.text,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 5,
                                child: ElevatedButton(
                                    onPressed: () {
                                      _image!.length < 2
                                          ? getImage(false)
                                          : print(_image!.length);
                                    },
                                    child: Icon(
                                      Icons.image_outlined,
                                      color: Palette.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      shadowColor: Palette.gold,
                                      elevation: 5,
                                      padding: EdgeInsets.all(10),
                                      backgroundColor:
                                          Palette.text, // <-- Splash color
                                    ))),
                            Text(
                              "Gallery",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Palette.text,
                              ),
                            )
                          ],
                        ),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Palette.gold),
                                  borderRadius: BorderRadius.circular(10)),
                              height: 150.0,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _image!.length,
                                itemBuilder: (context, index) => InkWell(
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      margin: EdgeInsets.all(10.0),
                                      child: Image.file(
                                        File(AddItemState._image![index].path),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    onTap: () => WidgetsBinding.instance
                                            .addPostFrameCallback((timeStamp) {
                                          showImages(context, _image![index]);
                                        })),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 25),
                      FormButton(
                          buttonIcon: Icons.add_shopping_cart,
                          textcolor: Colors.white,
                          backgroundColor: Colors.brown,
                          borderColor: Colors.brown,
                          text: "Add Item",
                          heightSize: 45,
                          widthSize: 200,
                          onPressed: () {
                            formKey.currentState!.validate();
                            saveItem(
                                itemNameController.text,
                                weightController.text,
                                sizeController.text,
                                quantityController.text,
                                meltController.text,
                                stampController.text,
                                hookController.text,
                                designController.text,
                                sizeSmplController.text,
                                refNoController.text,
                                remarkController.text,
                                'test base64',
                                daysController.text,
                                dueDateController.text,
                                context);
                          }),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void saveItem(
      String itemName,
      String weight,
      String size,
      String qty,
      String meltper,
      String stamp,
      String hook,
      String design,
      String sizeSample,
      String refNo,
      String imageData1,
      String remark,
      String days,
      String duedate,
      BuildContext context) {
    var isDataSave = PersisItemService().saveItem(
        itemName,
        double.tryParse(weight),
        size,
        int.tryParse(qty),
        double.tryParse(meltper),
        stamp,
        hook,
        design,
        sizeSample,
        refNo,
        imgToBase64(_image),
        remark,
        int.tryParse(days)!);
    formKey.currentState!.reset();
    itemNameController.clear();
    itemCodeController.clear();
    weightController.clear();
    sizeController.clear();
    quantityController.clear();
    meltController.clear();
    stampController.clear();
    hookController.clear();
    designController.clear();
    sizeSmplController.clear();
    refNoController.clear();
    remarkController.clear();
    daysController.clear();
    cnt.dropDownValue = null;
    dueDateController.clear();

    setState(() {
      _image!.clear();
    });

    AlertDialog alert = AlertDialog(
      backgroundColor: const Color(0xfffd4af37),
      title: const Text("Alert"),
      content: const Text('Item added '),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Ok')),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getStamp(meltval) {
    if (meltval.isEmpty) {
      stampController.text = "";
    } else {
      final stampData = AddItemService().getStamp(meltval);
      stampData.then((value) => stampController.text = value);
    } // stampController.text();
  }

  getDueDate(days) {
    if (days.isEmpty) {
      dueDateController.text = "";
    } else {
      final dueDate = AddItemService().getDueDate(days);
      dueDate.then((value) => dueDateController.text = value);
    } // stampController.text();
  }

  List<String> imgToBase64(List<XFile>? image) {
    // image
    List<String> listBase64Img = [];

    image?.map((e) => File(e.path)).forEach((element) {
      listBase64Img.add(base64Encode(element.readAsBytesSync()));
    });
    return listBase64Img;
  }

  //Show Image
  showImages(BuildContext context, XFile? images) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white70),
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 350,
                child: Column(
                  children: [
                    GestureDetector(
                      onDoubleTapDown: (details) => tapDowDetails = details,
                      onDoubleTap: () {
                        final position = tapDowDetails!.localPosition;
                        final double scale = 3;
                        final x = -position.dx * (scale - 1);
                        final y = -position.dy * (scale - 1);
                        final zoomed = Matrix4.identity()
                          ..translate(x, y)
                          ..scale(scale);
                        final zoomEnd = imgCtrl!.value.isIdentity()
                            ? zoomed
                            : Matrix4.identity();
                        animation =
                            Matrix4Tween(begin: imgCtrl?.value, end: zoomEnd)
                                .animate(CurveTween(curve: Curves.easeOut)
                                    .animate(animationController));
                        animationController.forward(from: 0);
                      },
                      child: InteractiveViewer(
                          transformationController: imgCtrl,
                          clipBehavior: Clip.none,
                          panEnabled: false,
                          scaleEnabled: false,
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: ClipRRect(
                                  child: Image.file(
                                File(images!.path),
                              )))),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    imgCtrl = TransformationController();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            imgCtrl!.value = animation!.value;
          });
  }

  @override
  void dispose() {
    super.dispose();
    imgCtrl?.dispose();
    animationController.dispose();
  }
}
