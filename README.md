# Android CAN Babel

This repository extends the `CANBabel` with some minor adaptions for easier use with Android, providing CAN `*.dbc` and `*.kcd` database usage for interpreting CAN protocol messages.


## Setup
The following commands are executed with respect to the root directory of this repository after cloning this repository with `git clone https://github.com/prothen/android_can_babel.git` and `cd android_can_babel`.
1. Install `maven` with `sudo apt install -y maven`
2. Build the CANBabel library with `cd external/canbabel && mvn clean install`
3. Copy the `CANBabel-2.1-jar-with-dependencies.jar` under `external/canbabel/target` into your Android app directory `app/libs` and go to `File->Project Structure->Dependencies`, select under `All Dependencies` the plus sign and add the `*.jar` file as jar dependency. (_Note: You can also test the library using `java -jar CANBabel-2.1-jar-with-dependencies.jar`_)

## Example
Import the following libraries
```java
import java.io.*;
import java.util.List;
import java.net.URL;
import com.github.canbabel.canio.kcd.Bus;
import com.github.canbabel.canio.kcd.Signal;
import com.github.canbabel.canio.kcd.Message;
import com.github.canbabel.canio.kcd.NetworkDefinition;
import com.github.canbabel.canio.dbc.DbcReader;
```
and use after the `onCreate` constructor with
```java
// DbcReader test
        DbcReader reader = new DbcReader();
        InputStream inputStream = null;
        try {
            inputStream = getAssets().open("test.dbc");
            reader.parseInputStream(inputStream, System.out, "test");
        } catch (IOException e) {
            e.printStackTrace();
        }

        NetworkDefinition n = reader.getNetwork();
        List<Bus> lb = n.getBus();
        Bus b = lb.get(CANBus);
        List<Message> lm = b.getMessage();
        String md = "odometer";
        for(Message mi : lm){
            if(mi.getName().equals(md)){
                Log.d("testtag", "Found message: " + md);
            }
        }
```



## License
Please note that this repository license applies only to the content excluding the `external` directory. The corresponding license of external libraries accompany its source code in the corresponding directory under `external`.
