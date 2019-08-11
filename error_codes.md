# Error Code Reference Sheet
All error codes are application specific and as such do not include exceptions thrown by dependencies, ruby interpreter, etc unless these are caught by AiDDA Wetter

This guide will be written in this format:

* **CODE**
  * _Exception_: ExceptionName
  * _Meaning_: Exception meaning here
  * _File_: file/defining/code
  * _Raised By_: # Starting from ada_wetter/lib
    * here/be/a
    * list/of/files/that
    * ../raising/this/code 



## General (Application Level) Errors

### Argument Errors:

* **10022**
  * _Exception_: ArgumentError
  * _Meaning_: General logical error with provided arguments
  * _File_: ada_wetter/helpers/error.rb
  * _Raised By_:
    * N/A (Namespace)
    
* **1639**
  * _Exception_: ArgumentConflictError
  * _Meaning_: Two (or more) arguments provided are logically conflicting
  * _File_: ada_wetter/helpers/error.rb
  * _Raised By_:
    * ada_wetter/cli.rb
```shell
     $ ada_wetter run --install-default-config --config ~/Documents/backups/ada_wetter/conf/settings.conf
     $ => Exception raised
     # These two arguments are logically opposed
```
