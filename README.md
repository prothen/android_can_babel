# Android CAN Babel

This repository extends the `CANBabel` with some minor adaptions for easier use with Android, providing CAN `*.dbc` and `*.kcd` database usage for interpreting CAN protocol messages.

## Usage
If you don't plan to adapt or customise the CANBabel, then this is the easiest setup. Simply use the `./resources/CANBabel.jar` and follow the [library installation guide](#library-installation).

## Build from source
This is recommended if you apply customisation to the CANBabel library.
Simply rebuild by using the `build.sh` script with edited `APP_DIR` variable (Update it with the location of your Android project root directory) and then executing

```bash
./build.sh
```

Alternatively follow the steps

1. Install `maven` with `sudo apt install -y maven`
2. Build the CANBabel library with `cd external/canbabel && mvn clean install`

_Note: The following commands are executed with respect to the root directory of this repository after cloning this repository with `git clone https://github.com/prothen/android_can_babel.git` and `cd android_can_babel`._

## Library Installation
Copy the `external/canbabel/target/CANBabel-2.1-jar-with-dependencies.jar` (or alternatively `resources/CANBabel.jar`) into your Android app directory `app/libs` and go to `File->Project Structure->Dependencies`, select under `All Dependencies` the plus sign and add the `*.jar` file as jar dependency. (_Note: You can also test the library using `java -jar CANBabel-2.1-jar-with-dependencies.jar`_)

## Example
Import the following libraries
```java
import java.io.*;
import java.util.List;
import java.net.URL;
import com.github.canbabel.canio.kcd.Signal;
import com.github.canbabel.canio.kcd.Message;
import com.github.canbabel.canio.dbc.DbcReader;
```
and use after the `onCreate` constructor with
```java
// DbcReader test
int busIndex = 0;
DbcReader reader = new DbcReader();
InputStream inputStream = null;
try {
    inputStream = getAssets().open("test.dbc");
    reader.parseInputStream(inputStream, System.out, "test");
} catch (IOException e) {
    e.printStackTrace();
}

List<Message> lm = reader.getMessages(busIndex);
String md = "odometer";
for(Message mi : lm){
    if(mi.getName().equals(md)){
        Log.d("testtag", "Found message: " + md);
    }
}
```



## License
Please note that this repository license applies only to the content excluding the `external` directory. The corresponding license of external libraries accompany its source code in the corresponding directory under `external`.
