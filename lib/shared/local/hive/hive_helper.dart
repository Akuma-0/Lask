import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Box? data;
Box? saved;
Future<Box> openHiveBox(boxName) async {
  if (!Hive.isBoxOpen(boxName)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxName);
}
