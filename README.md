badging_parser
==============

A parser of badging android aapt dumped.

When you want to extract badging info from a .apk file, you may do like this:
```sh
package=`aapt dump badging xxx.apk | grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g`
activity=`aapt dump badging xxx.apk | grep Activity | awk '{print $2}' | sed s/name=//g | sed s/\'//g`
echo
echo package : $package
echo activity: $activity
```
This is complicated as you can see. Instead, `badging_parser` transform aapt output into JSON object
directly, and you can get badging info just as get properties from an object.
```javascript
var $ = require('shelljs');
var parser = require('badging_parser');

var badging = parser.parse($.exec('aapt dump badging xxx.apk').output);
$.echo('package : ', badging.package.name);
$.echo('activity: ', badging['launchable-activity'].name);
```
