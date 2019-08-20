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

* **0101**
  * _Exception_: ArgumentError
  * _Meaning_: General logical error with provided arguments
  * _File_: ada_wetter/common/application/error.rb
  * _Raised By_:
    * None, used as a namespace
    
* **0102**
  * _Exception_: ArgumentError::ArgumentMismatchError
  * _Meaning_: Two (or more) arguments provided are logically conflicting
  * _File_: ada_wetter/common/application/error.rb (AdaWetter::Application::ArgumentError::ArgumentMismatchError)
  * _Raised By_:
    * ada_wetter/common/application/opts (AdaWetter::Application::Opts)
    ```shell
     $ ada_wetter run --install_default_config --config ~/Documents/backups/ada_wetter/conf/settings.conf
     $ => Exception raised
     # These two arguments are logically opposed
    ```
    
  * **0202**
    * _Exception_: VLogger::InvalidLevelArgument
    * _Meaning_: VLogger was passed an invalid STRING in the 'level' field when called on to log or announce a message. This exception is usually raised by an internal programming error or when attempting to use this library in another program.
    * _File_: ada_wetter/common/application/vb_logger.rb
    * _Raised_By_:
      * ada_wetter/common/application/vb_logger.rb
