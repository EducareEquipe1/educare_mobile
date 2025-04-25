import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final isLoading = false.obs;
  final oldPasswordVisible = false.obs;
  final newPasswordVisible = false.obs;
  final confirmPasswordVisible = false.obs;

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      isLoading.value = true;
      // TODO: Implement API call to change password
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      Get.back();
      Get.snackbar(
        'Succès',
        'Votre mot de passe a été modifié avec succès',
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur s\'est produite lors du changement de mot de passe',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _controller = Get.put(ChangePasswordController());
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Mot de passe'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(() {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPasswordField(
                  label: 'Ancien mot de passe',
                  controller: _oldPasswordController,
                  isVisible: _controller.oldPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre ancien mot de passe';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildPasswordField(
                  label: 'Nouveau mot de passe',
                  controller: _newPasswordController,
                  isVisible: _controller.newPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nouveau mot de passe';
                    }
                    if (value.length < 8) {
                      return 'Le mot de passe doit contenir au moins 8 caractères';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _buildPasswordField(
                  label: 'Confirmer nouveau mot de passe',
                  controller: _confirmPasswordController,
                  isVisible: _controller.confirmPasswordVisible,
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return 'Les mots de passe ne correspondent pas';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed:
                      _controller.isLoading.value
                          ? null
                          : _handleChangePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF678E90),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      _controller.isLoading.value
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text(
                            'Sauvgarder',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required RxBool isVisible,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4A5568),
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          return TextFormField(
            controller: controller,
            obscureText: !isVisible.value,
            validator: validator,
            decoration: InputDecoration(
              hintText: '******************',
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: const Color(0xFF718096),
                ),
                onPressed: () => isVisible.value = !isVisible.value,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF678E90)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          );
        }),
      ],
    );
  }

  void _handleChangePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      _controller.changePassword(
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
      );
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
