primitive Debug   fun apply(): String => "DEBUG"
primitive Info    fun apply(): String => "INFO"
primitive Warning fun apply(): String => "WARN"
primitive Failure fun apply(): String => "FAIL"
type LogLevel is (Debug | Info | Warning | Failure)

type Output is (StdStream | OutStream)

actor Logger
  let output: Output
  var level: LogLevel

  new create(output': Output, level': LogLevel = Info) =>
    output = output'
    level = level'

  be set_log_level(level': LogLevel) =>
    level = level'

  be log(message: String) =>
    output.print(message)

  be debug(message: String) =>
    _maybe_log(message, Debug)

  be info(message: String) =>
    _maybe_log(message, Info)

  be warn(message: String) =>
    _maybe_log(message, Warning)

  be fail(message: String) =>
    _maybe_log(message, Failure)

  fun _maybe_log(message: String, message_level: LogLevel) =>
    if _should_log(message_level) then
      log(message_level() + ": " + message)
    end

  fun _should_log(message_level: LogLevel) : Bool =>
    match (message_level(), level())
    | (level(), level())      => true
    | (_, Debug())            => true
    | (Warning(), Info())     => true
    | (Failure(), Info())     => true
    | (Failure(), Warning())  => true
    else
      false
    end
