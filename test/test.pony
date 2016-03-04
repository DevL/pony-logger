use "ponytest"
use "../logger"

actor TestOutput is OutStream
  be print(data: ByteSeq) => None
  be write(data: ByteSeq) => None
  be printv(data: ByteSeqIter) => None
  be writev(data: ByteSeqIter) => None

actor Main is TestList
  new create(env: Env) => PonyTest(env, this)

  new make() => None

  fun tag tests(test: PonyTest) =>
    test(_TestDebug)

class _TestDebug is UnitTest
  """
  Test the Debug log level.
  """
  fun name(): String => "Debug test"

  fun apply(h: TestHelper): TestResult =>
    let output = TestOutput.create()
    let logger = Logger(output, Debug)

    logger.debug("message")
    logger.info("message")
    logger.warn("message")
    logger.fail("message")

    // assert that output.print has been called 4 times

    h.expect_true(false)
