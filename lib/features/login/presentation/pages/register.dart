import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_system/config/extension/context_ex.dart';
import 'package:student_system/config/extension/num_extention.dart';
import 'package:student_system/config/extension/string_extention.dart';
import 'package:student_system/config/extension/widget_extension.dart';

import '../../../../config/utils/components.dart';
import '../../../../config/utils/def_button.dart';
import '../../../../config/utils/text_field.dart';
import '../../../home/presentation/pages/home.dart';
import '../../models/address.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../widgets/arrow.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPassword = true;
  IconData eyeIcon = Icons.visibility;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final governController = TextEditingController();
  final cityController = TextEditingController();
  final gradeController = TextEditingController();
  final subjectController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? governId;
  List<String> sub = [];

  AddressModel? addressModel;
  String currentValue = 'Subjects';
  String currentValue2 = 'Role';
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBack(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is RegisterError) {
                  C.snack(
                    context,
                    state.error,
                    onTap: () {
                      emailController.clear();
                      phoneController.clear();
                    },
                  );
                }
                if (state is RegisterSuccess) {
                  C.navToRemove(context, const Home());
                }
              },
              builder: (context, state) {
                var cubit = LoginCubit.get(context);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      "Hello! Register to get started",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    15.sbh,
                    DefTextField(
                      hintText: "Name",
                      validate: (name) {
                        if (name!.length < 4) {
                          return "Enter a valid name";
                        }
                        return null;
                      },
                      controller: nameController,
                      prefexicon: const Icon(Icons.person),
                    ),
                    15.sbh,
                    DefTextField(
                      validate: (value) {
                        if (!emailRegex.hasMatch(value!.trim())) {
                          return "Enter a valid Email";
                        }
                        return null;
                      },
                      hintText: "Email",
                      controller: emailController,
                      prefexicon: const Icon(Icons.email_outlined),
                    ),
                    15.sbh,
                    DefTextField(
                      validate: (value) {
                        if (!cubit.phoneRegex.hasMatch(value!.trim())) {
                          return "Enter a valid Phone";
                        }
                        return null;
                      },
                      hintText: "Phone",
                      controller: phoneController,
                      textInputType: TextInputType.number,
                      prefexicon: const Icon(Icons.phone),
                    ),
                    15.sbh,
                    DefTextField(
                      validate: (value) {
                        if (value!.isNotEmpty) {
                          if (int.parse(value) > 4) {
                            return "Enter a valid grade from (1-4)";
                          }
                          return null;
                        }
                        return null;
                      },
                      hintText: "Grade",
                      onChange: (p0) {
                        cubit.getSubjectWhenGrade(p0);
                      },
                      textInputType: TextInputType.number,
                      controller: gradeController,
                      prefexicon: const Icon(Icons.grade),
                    ),
                    15.sbh,
                    DefTextField(
                      isSecure: isPassword,
                      controller: passwordController,
                      validate: (value) {
                        if (value!.length < 8) {
                          return "Password must be more than 8 characters";
                        }
                        return null;
                      },
                      prefexicon: const Icon(Icons.lock_open_outlined),
                      hintText: "Password",
                      suffixicon: Icon(eyeIcon).onTap(() {
                        setState(() {
                          isPassword = !isPassword;
                          eyeIcon = isPassword
                              ? Icons.visibility
                              : Icons.visibility_off_outlined;
                        });
                      }),
                    ),
                    15.sbh,
                    DefTextField(
                      isSecure: isPassword,
                      validate: (value) {
                        if (value!.length < 8) {
                          return "Password must be more than 8 characters";
                        }
                        if (value != passwordController.text) {
                          return "⚠️ Password doesn't match";
                        }
                        return null;
                      },
                      controller: confirmPasswordController,
                      prefexicon: const Icon(Icons.lock_open_outlined),
                      hintText: "Confirm Password",
                      suffixicon: Icon(eyeIcon).onTap(() {
                        setState(() {
                          isPassword = !isPassword;
                          eyeIcon = isPassword
                              ? Icons.visibility
                              : Icons.visibility_off_outlined;
                        });
                      }),
                    ),
                    15.sbh,
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: context.sw(0.4),
                          child: DefTextField(
                            isEnabled: governController.text.isEmpty,
                            hintText: 'Governorate',
                            prefexicon: const Icon(Icons.place),
                            controller: governController,
                            onTap: () {
                              showListGovernModel(context);
                            },
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Governorate';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: context.sw(0.4),
                          child: DefTextField(
                            hintText: 'City',
                            onTap: () {
                              showListCityModel(context);
                            },
                            prefexicon: const Icon(Icons.location_city),
                            controller: cityController,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Ciry';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    15.sbh,
                    if (cubit.subjectModel != null)
                      Align(
                          alignment: Alignment.centerLeft,
                          child: 'Role'.txt(color: Colors.grey)),
                    15.sbh,
                    if (cubit.subjectModel != null)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: currentValue2,
                            onChanged: (String? newValue) {
                              if (newValue != 'Role') {
                                setState(() {
                                  currentValue2 = newValue!;
                                });
                              }
                            },
                            items: cubit.role
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: 300,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: C.getRandomColor(),
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: Text(
                                              value.split(' ').first[0] +
                                                  value.split(' ').last[0],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        10.sbw,
                                        Text(
                                          value,
                                          style: TextStyle(
                                              color: value == 'Role'
                                                  ? Colors.grey
                                                  : Colors.black),
                                        ),
                                        const Spacer(),
                                        // IconButton(
                                        //     onPressed: () {

                                        //     },
                                        //     icon: const Icon(Icons.check))
                                      ],
                                    ).paddingSymmetric(10, 0),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
                    15.sbh,
                    if (cubit.subjectModel != null)
                      Align(
                          alignment: Alignment.centerLeft,
                          child: 'Subject'.txt(color: Colors.grey)),
                    15.sbh,
                    if (cubit.subjectModel != null)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: currentValue,
                            onChanged: (String? newValue) {
                              if (newValue != 'Subjects') {
                                setState(() {
                                  currentValue = newValue!;
                                  sub.add(newValue);
                                });
                              }
                            },
                            items: cubit.subjectsNames
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: 300,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: C.getRandomColor(),
                                              shape: BoxShape.circle),
                                          child: Center(
                                            child: Text(
                                              value.split(' ').first[0] +
                                                  value.split(' ').last[0],
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        10.sbw,
                                        Text(
                                          value,
                                          style: TextStyle(
                                              color: value == 'Subjects'
                                                  ? Colors.grey
                                                  : Colors.black),
                                        ),
                                        const Spacer(),
                                        // IconButton(
                                        //     onPressed: () {

                                        //     },
                                        //     icon: const Icon(Icons.check))
                                      ],
                                    ).paddingSymmetric(10, 0),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ),
                    if (sub.isNotEmpty) 15.sbh,
                    if (sub.isNotEmpty)
                      Wrap(
                        children: List.generate(
                          sub.length,
                          (index) => Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) {
                              setState(() {
                                sub.removeAt(index);
                              });
                            },
                            background: Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.red,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  'Delete'.txt(color: Colors.white)
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: C.getRandomColor(),
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        sub[index].split(' ').first[0] +
                                            sub[index].split(' ').last[0],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Text(sub[index]),
                                  // const Spacer(),
                                  // IconButton(
                                  //     onPressed: () {

                                  //     },
                                  //     icon: const Icon(Icons.delete))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    15.sbh,
                    DefButton(
                      text: "Register",
                      color: Colors.black,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.register(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                            role: currentValue2,
                            grade: int.parse(gradeController.text),
                            address: addressModel!,
                          );
                        }
                      },
                      isLoading: state is RegisterLoading,
                    ),
                    15.sbh,
                    Row(
                      children: [
                        Container(
                          width: context.sw(0.32),
                          height: 1,
                          color: Colors.grey,
                        ),
                        7.5.sbw,
                        'Or Login with'.txt(color: Colors.grey),
                        7.5.sbw,
                        Container(
                          width: context.sw(0.32),
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    15.sbh,
                    SizedBox(
                      height: context.sh(0.068),
                      width: Platform.isIOS ? context.width : context.sw(0.56),
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return _socialButton(Platform.isIOS
                                ? ['facebook', 'google_ic', 'apple'][index]
                                : ['facebook', 'google_ic'][index]);
                          },
                          separatorBuilder: (context, index) => 15.sbw,
                          itemCount: Platform.isIOS ? 3 : 2),
                    ),
                    context.sw(0.29).sbh,
                    Row(
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              C.pop(
                                context,
                              );
                            },
                            child: 'Login Now'.txt(color: Colors.green))
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  showListGovernModel(BuildContext context) {
    var cubit = LoginCubit.get(context);
    Widget builder = SingleChildScrollView(
      child: Column(
        children: List.generate(
            cubit.govern.length,
            (index) => ListTile(
                  onTap: () {
                    governController.text = cubit.govern[index].governEn!;
                    setState(() {
                      governId = cubit.govern[index].id;
                    });
                    C.pop(context);
                  },
                  leading: Text(cubit.govern[index].id!),
                  title: Text(
                      "${cubit.govern[index].governAR} - ${cubit.govern[index].governEn}"),
                )),
      ),
    );

    showModalBottomSheet(context: context, builder: (context) => builder);
  }

  showListCityModel(BuildContext context) {
    var cubit = LoginCubit.get(context);

    final cities =
        cubit.city.where((element) => element.id == governId).toList();

    Widget builder = SingleChildScrollView(
      child: Column(
        children: List.generate(
            cities.length,
            (index) => ListTile(
                  onTap: () {
                    cityController.text = cities[index].cityEN!;
                    setState(() {
                      addressModel = AddressModel(
                          city: cityController.text,
                          govern: governController.text);
                    });
                    C.pop(context);
                  },
                  leading: Text((index + 1).toString()),
                  title:
                      Text("${cities[index].cityAR} - ${cities[index].cityEN}"),
                )),
      ),
    );

    showModalBottomSheet(context: context, builder: (context) => builder);
  }

  Widget _socialButton(String asseticon) {
    return Container(
      width: 100,
      height: 60,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 1)),
      child: SvgPicture.asset(asseticon.toSvg),
    ).onTap(() {
      if (asseticon == 'google_ic') {
        // LoginCubit.get(context).getSubjectWhenGrade("3");
      }
    });
  }
}
