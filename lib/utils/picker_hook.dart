import 'package:image_picker/image_picker.dart';
import 'package:pi_papers_2021_2/utils/image_hook.dart';

void usePicker(ImageInterface target) async {
  final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  if (pickedFile == null) return;

  final fileBytes = await pickedFile.readAsBytes();
  target.data = fileBytes;
}
