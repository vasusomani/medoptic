import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medoptic/Constants/colors.dart';
import 'package:medoptic/services/api_services/user_api.dart';
import 'package:medoptic/services/helper_functions/toast_util.dart';
import '../../../model/user_model.dart';
import '../../../services/state_management_services/user_riverpod.dart';
import '../../components/buttons.dart';
import '../../components/textfields.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController nameController;
  // late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController profilePicController;
  late TextEditingController storeNameController;
  late TextEditingController storeAddressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    // emailController = TextEditingController();
    phoneController = TextEditingController();
    profilePicController = TextEditingController();
    storeNameController = TextEditingController();
    storeAddressController = TextEditingController();

    _initializeControllers();
  }

  void _initializeControllers() {
    final user = ref.read(userProvider);
    phoneController.text = user?.phone ?? '';
    nameController.text = user?.name ?? '';
    // emailController.text = user?.email ?? '';
    storeNameController.text = user?.storeName ?? '';
    storeAddressController.text = user?.storeAddress ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text('My Profile',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () => _showAvatarOptions(context),
                splashFactory: NoSplash.splashFactory,
                child: CircleAvatar(
                  backgroundColor: CustomColors.primaryLightColor,
                  radius: 70,
                  child: ClipOval(
                    child: (user?.profilePic != null && user?.profilePic != "")
                        ? Center(
                            child: Image.network(
                              user!.profilePic!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const FittedBox(
                            fit: BoxFit.cover,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              MedTagTextField(
                controller: nameController,
                hint: "Enter user name",
                keyboardType: TextInputType.text,
                title: "Name",
              ),
              // const SizedBox(height: 15),
              // PrescriptionTextField(
              //   controller: emailController,
              //   hint: "Enter email",
              //   keyboardType: TextInputType.emailAddress,
              //   title: "Email",
              // ),
              const SizedBox(height: 15),
              MedTagTextField(
                controller: phoneController,
                hint: "Enter phone number",
                keyboardType: TextInputType.text,
                title: "Phone Number",
                disabled: true,
              ),
              const SizedBox(height: 15),
              MedTagTextField(
                controller: storeNameController,
                hint: "Enter store name",
                keyboardType: TextInputType.text,
                title: "Store Name",
              ),
              const SizedBox(height: 15),
              MedTagTextField(
                controller: storeAddressController,
                hint: "Enter store address",
                keyboardType: TextInputType.text,
                title: "Store Address",
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                text: 'Save Profile',
                onPressed: _saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAvatarOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () {
                // Handle choose from gallery
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a picture'),
              onTap: () {
                // Handle take a picture
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Remove picture'),
              onTap: () {
                // Handle remove picture
              },
            ),
          ],
        );
      },
    );
  }

  _saveProfile() async {
    UserModel updatedUser = UserModel(
      name: nameController.text,
      // email: emailController.text,
      phone: phoneController.text,
      profilePic: profilePicController.text,
      storeName: storeNameController.text,
      storeAddress: storeAddressController.text,
    );
    debugPrint("Updated user: ${updatedUser.toJson().toString()}");
    ref.read(userProvider.notifier).setUser(updatedUser);
    try {
      final responseBody = await UserApi().updateUser(
        name: nameController.text,
        // email: emailController.text,
        storeName: storeNameController.text,
        storeAddress: storeAddressController.text,
      );
      debugPrint(responseBody.toString());
    } catch (e) {
      ToastWidget.bottomToast(e.toString());
    }
    ToastWidget.bottomToast("Profile updated successfully");

    // Re-fetch user data to ensure the UI is updated
    _initializeControllers();
    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    // emailController.dispose();
    profilePicController.dispose();
    phoneController.dispose();
    storeNameController.dispose();
    storeAddressController.dispose();
    super.dispose();
  }
}
